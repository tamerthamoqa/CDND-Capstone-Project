import torch
import torchvision.transforms as transforms
import io
import os
import json
import logging
from base64 import b64encode
from PIL import Image
from flask import Flask, request, render_template
from waitress import serve


app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 10 * 1024 * 1024
app.secret_key = os.urandom(24)
ALLOWED_EXTENSIONS = {'png', 'PNG', 'jpg', 'JPG', 'jpeg', 'JPEG'}

logger = logging.getLogger('waitress')
logger.setLevel(logging.INFO)


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS


@app.route('/')
def home():
    return render_template('index.html', result=None)


@app.route('/predict', methods=['GET', 'POST'])
def predict():
    if request.method == 'POST':
        file = request.files['file']

        if file and allowed_file(file.filename):
            # Pre-process input image
            img = Image.open(file)
            input_img = preprocess(img)
            input_img = input_img.unsqueeze(0)

            # Model inference
            prediction = model(input_img.to(device))
            top_1_prediction = prediction.max(dim=1)
            prediction_probability = "{:.2f}%".format(float(top_1_prediction[0]))
            prediction_class = imagenet_class_index[str(int(top_1_prediction[1]))]
            logger.info("Prediction Class: {}\nPrediction Probability: {}".format(
                    prediction_class,
                    prediction_probability
                )
            )

            # Prepare display image on HTML page
            display_img = io.BytesIO()
            img.save(display_img, format='PNG')
            display_img.seek(0, 0)
            output = "data:image/png;base64," + b64encode(display_img.getvalue()).decode('ascii')

    return render_template(
        "index.html",
        prediction_class=prediction_class,
        prediction_probability=prediction_probability,
        display_img=output
    )


if __name__ == '__main__':

    # Load imagenet class index
    imagenet_class_index = json.load(open('model/imagenet_class_index.json'))

    # Load model on an available CPU or GPU
    flag_gpu_available = torch.cuda.is_available()
    if flag_gpu_available:
        device = torch.device("cuda")
    else:
        device = torch.device("cpu")

    model = torch.load('model/mobilenet_v2.pt')
    model.to(device)
    model.eval()

    # Input image pre-processing steps
    preprocess = transforms.Compose([
        transforms.Resize(size=224),  # Pre-trained model uses 224x224 input images
        transforms.ToTensor(),
        transforms.Normalize(
            mean=[0.485, 0.456, 0.406],  # Pre-trained ImageNet model input image normalization settings
            std=[0.229, 0.224, 0.225]
        )
    ])

    # Start flask application on waitress WSGI server
    serve(app=app, host='0.0.0.0', port=80, threads=4)

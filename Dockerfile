# Import Nvidia CUDA image to be able to run on GPU
FROM nvidia/cuda:10.2-base

WORKDIR /app

# Copy source code
COPY server.py /app/
COPY model /app/model/
COPY templates /app/templates
COPY requirements.txt /app/

# hadolint ignore=DL3008,DL3009,DL3015
RUN apt-get -y update \
    && apt-get install -y software-properties-common \
    && apt-get -y update \
    && add-apt-repository universe
# hadolint ignore=DL3009
RUN apt-get -y update

# Install Python 3.7
# hadolint ignore=DL3008,DL3015
RUN apt-get -y install python3.7 && \
    apt-get -y install python3-pip

# Make python3 point to python3.7 interpreter
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1

# Install required packages
# hadolint ignore=DL3013
RUN pip3 install --upgrade pip && \
    pip3 install --upgrade setuptools && \
    pip3 install -r requirements.txt

EXPOSE 80

CMD ["python3", "server.py"]

FROM python:3.7.9-stretch

WORKDIR /app

COPY server.py /app/
COPY model /app/model/
COPY templates /app/templates
COPY requirements.txt /app/

# hadolint ignore=DL3013
RUN pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    pip install -r requirements.txt

EXPOSE 80

CMD ["python", "server.py"]

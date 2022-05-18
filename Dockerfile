FROM python:3.10-alpine

WORKDIR /workdir

RUN pip3 install --no-cache-dir --upgrade pip==22.1

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && \
    rm requirements.txt

COPY k8s-secrets.py /usr/local/bin/

ENTRYPOINT [ "k8s-secrets.py" ]


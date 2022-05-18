FROM python:3.10-alpine

WORKDIR /workdir

COPY requirements.txt .
RUN pip3 install --no-cache-dir --upgrade pip==22.1 && \
    pip3 install --no-cache-dir -r requirements.txt

ENTRYPOINT [ "python3" ]
CMD [ "k8s-secrets.py" ]


FROM python:3.10-alpine

WORKDIR /workdir

RUN apk add --no-cache curl=7.80.0-r1 && \
    pip3 install --no-cache-dir --upgrade pip==22.1

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && \
    rm requirements.txt

RUN curl --silent \
         -L https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator \
         -o /usr/local/bin/aws-iam-authenticator && \
    chmod +x /usr/local/bin/aws-iam-authenticator

COPY k8s-secrets.py /usr/local/bin/

ENTRYPOINT [ "k8s-secrets.py" ]


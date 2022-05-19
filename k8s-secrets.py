#!/usr/local/bin/python3

from kubernetes import client, config
from termcolor import colored
from os import getenv
from sys import exit
from requests import post
from base64 import b64decode


def upload_to_pastebin(paste):
    headers = {
        'Content-Type': 'application/x-www-form',
    }
    params = {
        "burn": "true",
        "ttl": 300
    }
    response = post(
        url=PASTE_URL,
        data=paste,
        params=params,
        headers=headers
    )
    return response.text


def get_secrets():
    secrets = v1.list_secret_for_all_namespaces()
    for i in secrets.items:
        print(f"==> {colored(i.metadata.name, 'yellow')} (namespace: {i.metadata.namespace}):")
        for k, v in i.data.items():
            print(f"      {colored(k, 'green')}: ***hidden*secret***")
        print()


def get_named_secret(name, namespace):
    secret = v1.read_namespaced_secret(name, namespace)
    print(f"==> {colored(secret.metadata.name, 'yellow')} (namespace: {secret.metadata.namespace}):")
    for k, v in secret.data.items():
        paste_link = upload_to_pastebin(b64decode(v))
        print(f"      {colored(k, 'green')}: {paste_link}")


if __name__ == "__main__":
    config.load_kube_config()
    v1 = client.CoreV1Api()

    ACTION = getenv("ACTION")

    match ACTION:
        case "list":
            get_secrets()
        case "show":
            SECRET = getenv("SECRET")
            NAMESPACE = getenv("NAMESPACE")
            PASTE_URL = getenv("PASTE_URL")
            get_named_secret(SECRET, NAMESPACE)
        case "add":
            print("Will be implemented soon")
        case "delete":
            print("Will be implemented soon")
        case _:
            print("ACTION is not set or incorrect")
            exit(1)

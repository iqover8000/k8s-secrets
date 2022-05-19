#!/usr/local/bin/python3

from kubernetes import client, config
from termcolor import colored
from os import getenv
from sys import exit


def get_secrets():
    secrets = v1.list_secret_for_all_namespaces()
    for i in secrets.items:
        print(f"==> {colored(i.metadata.name, 'yellow')} (namespace: {i.metadata.namespace}):")
        for k, v in i.data.items():
            print(f"      {colored(k, 'green')}: ***hidden*secret***")
        print()


def get_secret(name, namespace, key):
    secret = v1.read_namespaced_secret(name, namespace)
    print(secret)
    # for i in secrets.items:
    #     print(f"==> {colored(i.metadata.name, 'yellow')} (namespace: {i.metadata.namespace}):")
    #     for k, v in i.data.items():
    #         print(f"      {colored(k, 'green')}: ***hidden*secret***")
    #     print()


if __name__ == "__main__":
    config.load_kube_config()
    v1 = client.CoreV1Api()

    ACTION = getenv("ACTION")
    OTS_URL = 'https://onetimesecret.com'
    OTS_USER = getenv("OTS_USER")
    OTS_USER = getenv("OTS_TOKEN")

    match ACTION:
        case "list":
            get_secrets()
        case "show":
            SECRET = getenv("SECRET")
            NAMESPACE = getenv("NAMESPACE")
            KEY = getenv("KEY")
            get_secret(SECRET, NAMESPACE, KEY)
        case "add":
            print("Will be implemented soon")
        case "delete":
            print("Will be implemented soon")
        case _:
            print("ACTION is not set or incorrect")
            exit(1)

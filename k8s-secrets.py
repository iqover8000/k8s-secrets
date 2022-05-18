#!/usr/local/bin/python3

from kubernetes import client, config
from termcolor import colored

config.load_kube_config()
v1 = client.CoreV1Api()

secrets = v1.list_secret_for_all_namespaces()

for i in secrets.items:
    print(f"==> {colored(i.metadata.name, 'yellow')} (namespace: {i.metadata.namespace}):")
    for k, v in i.data.items():
        print(f"      {colored(k, 'green')}: ***hidden*secret***")
    print()

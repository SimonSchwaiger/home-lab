#!/usr/bin/python

""" Reads the secrets file and formats inventory file containing pc's IP """

import os
import yaml
from yaml.loader import SafeLoader

with open('/vars/secrets.yaml') as f:
    secrets = yaml.load(f, Loader=SafeLoader)

try: 
    with open('/app/inventory', 'w') as f:
        f.write("[target]\n")
        f.write("{}".format(secrets["pc_ip"]))
except AttributeError:
    print("Secrets File does not contain pc_ip variable!")

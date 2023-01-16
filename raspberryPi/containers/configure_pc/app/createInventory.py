#!/usr/bin/python

""" Reads the secrets file and formats inventory file containing pc's IP """

import os
import yaml
from yaml.loader import SafeLoader

with open('/app/vars/secrets.yml') as f:
    secrets = yaml.load(f, Loader=SafeLoader)

try: 
    with open('/app/inventory', 'w') as f:
        #f.write("[target]\n")
        f.write("{}\n".format(secrets["pc_ip"]))
        f.write("\n[all:vars]\nansible_connection=ssh\n")
        f.write("ansible_user={}\n".format(secrets["pc_user"]))
        f.write("ansible_password={}\n".format(secrets["pc_password"]))
        f.write("ansible_sudo_pass={}\n".format(secrets["pc_password"]))
except AttributeError:
    print("Secrets File does not contain required variables (pc_ip, pc_user, pc_password)")

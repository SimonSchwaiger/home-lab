#!/bin/bash
# This script installs python3, creates a default python venv (~/myenv) and installs ansible
# Ansible uses a playbook to configure docker and the vpn
# https://linuxtut.com/en/ee2b74a66b14067cdea7/

## Get script directory
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

## Python
alias python="python3"
alias pip="pip3"

sudo apt-get update

sudo apt-get install -y cmake libopenmpi-dev zlib1g-dev \
    python3 \
    python3-pip \
    python3-venv \
    python3-tk \
    python3-setuptools \
    && pip3 install virtualenv

# Check if rust is present. If not, install it for cryptography python package (required for ansible)
# https://lightrun.com/answers/snipsco-snips-nlu-error-can-not-find-rust-compiler-on-armv7-unknown-linux-gnueabihf
source $HOME/.cargo/env
if ! [ -x "$(command -v rustc)" ]; then
  curl https://sh.rustup.rs -sSf | sh && source $HOME/.cargo/env
fi

VENVDIR="/home/pi/myenv"

if [ ! -d "$VENVDIR" ]; then 
    # Create Virtualenv
    virtualenv -p /usr/bin/python3 $VENVDIR
    # Activate venv each time a terminal is opened
    echo "" >> ~/.bashrc
    echo "# Activate Default Python3 Virtualenv" >> ~/.bashrc
    echo "source $VENVDIR/bin/activate" >> ~/.bashrc
fi

# Install requirements (including ansible)
source $VENVDIR/bin/activate && pip3 install --upgrade pip &&  pip3 install -r requirements.txt

# Install ansible zerotier role
source $VENVDIR/bin/activate && ansible-galaxy install m4rcu5nl.zerotier-one

## Add systemd service to start ansible playbook everytime the pi starts up
# https://www.dexterindustries.com/howto/run-a-program-on-your-raspberry-pi-at-startup/
# Can be uninstalled using *sudo rm /lib/systemd/system/playbook.service*
# Create service file
echo "[Unit]
Description=Ansible Playbook Service
After=multi-user.target

[Service]
Type=exec
ExecStart=$VENVDIR/bin/ansible-playbook -i $SCRIPTDIR/inventory $SCRIPTDIR/raspiPlaybook.yaml

[Install]
WantedBy=multi-user.target" >> playbook.service
# Copy service file to systemd folder
sudo cp playbook.service /lib/systemd/system/
# Make service file executable
sudo chmod 644 /lib/systemd/system/playbook.service
# Delete local service file
rm playbook.service

# Use ansible to install everything
source $VENVDIR/bin/activate && ansible-playbook -i inventory raspiPlaybook.yaml


## TODO: Integrate into ansible playbook:
# Raspbi samba config share: 
# https://pimylifeup.com/raspberry-pi-samba/

## TODO: Integrate better ssh setup into ansible playbook

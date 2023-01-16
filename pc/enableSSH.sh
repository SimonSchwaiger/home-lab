#!/bin/bash

# Based on https://www.fosslinux.com/78569/install-and-enable-openssh-on-ubuntu.htm
# Install SSH
sudo apt-get update
sudo apt-get install -y openssh-server
sudo apt-get install -y openssh-client

# Enable and start ssh service
sudo systemctl enable ssh
sudo systemctl start ssh

# Configure firewall to accept ssh connections
sudo ufw allow ssh
sudo ufw enable
sudo ufw reload

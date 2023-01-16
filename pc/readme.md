# Server Configuration Files

## Installation

0. Install host OS and setup username + password (also used for ssh; tested using Ubuntu 22.04 LTS). Enable login without password and disable automatic suspend and screen blank in power settings.
1. Clone full repository to *~/git*
2. Run the [enableSSH.sh](./enableSSH.sh) script
3. Copy the server's IP address (from the `ifconfig` command) and save it to the raspberry's secrets file, alongside ssh username and password


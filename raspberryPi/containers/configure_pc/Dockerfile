FROM ubuntu:focal

ONBUILD ENV DEBIAN_FRONTEND="noninteractive"

# Install python and ansible. pyyaml is required for formatting the inventory file
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    python3 python3-pip python-is-python3 openssh-client openssh-server sshpass \
    && pip3 install ansible pyyaml

# Install ansible samba collection
RUN ansible-galaxy collection install vladgh.samba  --upgrade

# Copy, script, playbook and secrets (all in app folder)
COPY ./app/ /app/

# Create inventory file
RUN python /app/createInventory.py

ENV ANSIBLE_HOST_KEY_CHECKING=False

# Run script to indefinetly check for the pc being present
CMD "ansible-playbook" "-i" "/app/inventory" "/app/serverPlaybook.yml"

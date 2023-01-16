FROM ubuntu:focal

ONBUILD ENV DEBIAN_FRONTEND="noninteractive"

# Install python and ansible. pyyaml is required for formatting the inventory file
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    python3 python3-pip python-is-python3 openssh-client openssh-server sshpass \
    && pip3 install ansible pyyaml

# Copy, script, playbook and get secrets
COPY ./app/ /app/
#COPY ../../vars/ /app/vars/

# Create inventory file
RUN python /app/createInventory.py

ENV ANSIBLE_HOST_KEY_CHECKING=False

# Run script to indefinetly check for the pc being present
CMD "ansible-playbook" "-i" "/app/inventory" "/app/serverPlaybook.yml"

FROM ubuntu:focal

ONBUILD ENV DEBIAN_FRONTEND="noninteractive"

# Install python and ansible. pyyaml is required for formatting the inventory file
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    python3 python3-pip python3-is-python \
    && pip3 install ansible pyyaml

# Copy, script, playbook and get secrets
COPY ./app/ /app/
COPY ../../vars /vars/

# Create inventory file
RUN python /app/createInventory.py

# Run script to indefinetly check for the pc being present
CMD ["ansible-playbook" "-i" "inventory" "/app/serverPlaybook.yaml"]

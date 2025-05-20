#!/bin/bash

# Remove any existing container with the same name
docker rm -f my-ansible-container 2>/dev/null || true

# Build the Docker image
docker build -t my-ansible-image .

# Create a container from the image with a command to keep it running
docker run -d --name my-ansible-container my-ansible-image sleep infinity

# Copy the entire project directory to the container
docker cp . my-ansible-container:/ansible

# Run the playbook in the container with the correct working directory
docker exec -w /ansible my-ansible-container ansible-playbook playbook.yml

# Clean up
docker rm -f my-ansible-container

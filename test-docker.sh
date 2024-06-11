#!/bin/bash

# Build the Docker image
docker build -t my-ansible-image .

# Create a container from the image
docker run -d --name my-ansible-container my-ansible-image

# # Copy the playbook to the container
docker cp playbook.yml my-ansible-container:/home/node

# # Run the playbook in the container
docker exec -it my-ansible-container ansible-playbook /home/node/playbook.yml

# # Clean up
# docker rm -f my-ansible-container

#!/bin/bash

# Check if Ansible is installed
if ! command -v ansible >/dev/null; then
  # Install Ansible if it's missing
  echo "Ansible is not installed. Installing..."
  if [[ "$(uname)" == "Darwin" ]]; then
    # MacOS
    brew install ansible
  elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    # Linux
    sudo apt-get update && sudo apt-get install -y ansible
  elif [[ "$(ver)" == *"Windows"* ]]; then
    # Windows
    choco install ansible
  fi
fi

# Execute the playbook
ansible-playbook -i hosts.ini playbook.yml
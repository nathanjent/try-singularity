#!/bin/sh

# Assure dependencies are installed
sudo apt install -y python3-pip python3-setuptools

# Install Singularity Compose
sudo -H pip3 install singularity-compose

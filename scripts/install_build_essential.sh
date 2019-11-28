#!/bin/sh

# Assure basics are installed
DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y build-essential wget git

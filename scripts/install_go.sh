#!/bin/sh

# Add backport PPA for Go
sudo add-apt-repository ppa:longsleep/golang-backports

# Update and install
apt-get update
apt-get install -y golang-go

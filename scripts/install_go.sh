#!/bin/sh

DEBIAN_FRONTEND=noninteractive

# Add backport PPA for Go
add-apt-repository ppa:longsleep/golang-backports

# Update and install
apt-get install -y golang-go

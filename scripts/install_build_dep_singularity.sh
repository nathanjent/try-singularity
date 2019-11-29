#!/bin/sh

# Add build dependencies for Singularity
DEBIAN_FRONTEND=noninteractive
apt-get install -y \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    pkg-config \
    cryptsetup


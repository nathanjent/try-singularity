#!/bin/sh

# Install Singularity from source

# Add build dependencies
DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y \
    uuid-dev \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    pkg-config

if [ ! -d singularity ]; then
    tar -xzf "downloads/singularity-${SINGULARITY_VERSION}.tar.gz"
    cd singularity

    ./mconfig 
    make -C builddir 
    sudo make -C builddir install
fi

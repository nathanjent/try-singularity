#!/bin/sh

# Install Singularity from source

# Add build dependencies
sudo apt-get install -y \
    uuid-dev \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    pkg-config

if [ ! -d singularity ]; then
    tar -xzf "singularity-${SINGULARITY_VERSION}.tar.gz"
    cd singularity

    ./mconfig 
    make -C builddir 
    sudo make -C builddir install
fi

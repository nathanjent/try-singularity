#!/bin/sh

# Install Singularity from source

# Add backport PPA for Go
sudo add-apt-repository ppa:longsleep/golang-backports

# Update and add build dependencies
apt-get update
apt-get install -y build-essential libssl-dev uuid-dev libgpgme11-dev squashfs-tools libseccomp-dev wget pkg-config git golang-go

if [ ! -d singularity ]; then
    # Set the version of Singularity to install
    export VERSION=3.3.0

    wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz
    tar -xzf singularity-${VERSION}.tar.gz 
    cd singularity

    ./mconfig 
    make -C builddir 
    make -C builddir install
fi

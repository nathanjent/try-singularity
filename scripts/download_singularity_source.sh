#!/bin/sh

if [ ! -f singularity-${SINGULARITY_VERSION}.tar.gz ]; then
    wget https://github.com/sylabs/singularity/releases/download/v${SINGULARITY_VERSION}/singularity-${SINGULARITY_VERSION}.tar.gz
fi

#!/bin/sh

# Build Singularity from source
if [ ! -d singularity ]; then
    tar -xzf "downloads/singularity-${SINGULARITY_VERSION}.tar.gz"
    cd singularity

    ./mconfig 
    make -C builddir 
fi

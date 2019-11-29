#!/bin/sh

# Install Singularity

cd singularity

command -v singularity >/dev/null 2>&1 || make -C builddir install

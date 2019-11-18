#!/bin/sh

# Build the composed Singularity containers
cd containers
singularity-compose build

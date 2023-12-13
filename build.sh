#!/bin/bash

# Get the CPU architecture
arch=$(uname -m)

# Check if it's arm64
if [ "$arch" = "aarch64" ]; then
    echo "This is an arm64 architecture."
elif [ "$arch" = "x86_64" ]; then
    echo "This is an amd64 (x86_64) architecture."
    docker build --rm --no-cache -f Dockerfile -t myhugo .
elif [ "$arch" = "arm64" ]; then
    echo "This is an arm64 architecture."
    docker build --rm --no-cache -f Dockerfile.arm64 -t myhugo .
else
    echo "Unsupported architecture: $arch"
    exit 1
fi
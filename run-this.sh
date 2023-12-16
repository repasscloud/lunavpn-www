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

# Stop the nginx container if it exists
if docker ps -a --format '{{.Names}}' | grep -q '^nginx$'; then
    docker stop nginx
fi

# Run your build script
./npm-build.sh

# Run Nginx container
docker run --rm -d -p 80:80 -v $(pwd)/app/public:/usr/share/nginx/html --name nginx nginx
echo "Runs on http://localhost:80/"
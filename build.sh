#!/bin/bash

# Download Hugoplate
mkdir app
curl -L -o main.zip https://github.com/zeon-studio/hugoplate/archive/refs/heads/main.zip \
  && unzip main.zip \
  && rm main.zip \
  && mv hugoplate-main/* app/ \
  && rm -rf hugoplate-main

# Build Docker image
docker build --rm --no-cache -t myhugo .

# Run Docker container, mounting the local ./app directory to /app
docker run -v "$(pwd)/app:/app" myhugo /bin/bash -c \
  "npm run project-setup && npm install && sed -i 's/timeZone = \"America\/New_York\"/timeZone = \"UTC\"/' hugo.toml && npm run build"


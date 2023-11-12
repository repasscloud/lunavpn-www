#!/bin/bash

# Download Hugoplate
mkdir app
curl -L -o main.zip https://github.com/zeon-studio/hugoplate/archive/refs/heads/main.zip \
  && unzip main.zip \
  && rm main.zip \
  && mv hugoplate-main/* app/ \
  && rm -rf hugoplate-main

# Download Hugo (extended)
curl -L -o hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v0.120.4/hugo_extended_0.120.4_linux-amd64.tar.gz" \
  && tar -zxvf hugo.tar.gz \
  && rm hugo.tar.gz \
  && rm LICENSE

# Download and install Go
curl -L -o go.tar.gz "https://go.dev/dl/go1.21.4.linux-amd64.tar.gz" \

# Build Docker image
docker build --rm --no-cache -t myhugo .

# Run Docker container, mounting the local ./app directory to /app
docker run -v "$(pwd)/app:/app" myhugo /bin/bash -c \
  "npm run project-setup && npm install && sed -i 's/timeZone = \"America\/New_York\"/timeZone = \"UTC\"/' hugo.toml && npm run build"


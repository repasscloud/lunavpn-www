#!/bin/bash

# Take ownership of directory
echo -e "TeddyBear101" | sudo -S chown -R $(id -u):$(id -g) $SCRIPT_DIR
echo -e "TeddyBear101" | sudo -S chmod -R 755 $SCRIPT_DIR

# clear app directory
echo -e "TeddyBear101" | sudo rm -rf $SCRIPT_DIR/app
echo -e "TeddyBear101" | sudo rm -rf $SCRIPT_DIR/hugoplate-main

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

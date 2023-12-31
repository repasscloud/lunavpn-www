# Use the Ubuntu base image
FROM node:slim

# Set the working directory
WORKDIR /app

# Install required packages and cleanup
RUN /usr/bin/sh -c set -eux
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install -y \
    curl \
    git \
    npm \
    golang-go \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Update NPM
RUN npm install -g npm

# Download and install Hugo (extended)
RUN curl -L -o hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v0.120.4/hugo_extended_0.120.4_linux-amd64.tar.gz" \
    && tar -zxvf hugo.tar.gz \
    && mv hugo /usr/local/bin/hugo \
    && rm hugo.tar.gz

# Download and install Go
RUN curl -L -o go.tar.gz "https://go.dev/dl/go1.21.4.linux-amd64.tar.gz" \
    && tar -zxvf go.tar.gz \
    && mv go /usr/local/bin/go \
    && rm go.tar.gz

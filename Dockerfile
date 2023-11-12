# Use the Ubuntu base image
FROM node:slim

# Set the working directory
WORKDIR /app

# Install required packages and cleanup
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    npm \
    golang-go \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install Hugo
RUN curl -L -o hugo.tar.gz "https://github.com/gohugoio/hugo/releases/download/v0.120.4/hugo_extended_0.120.4_linux-amd64.tar.gz" \
    && tar -zxvf hugo.tar.gz \
    && mv hugo /usr/local/bin/hugo \
    && rm hugo.tar.gz

# Download and install Go
RUN curl -L -o go.tar.gz "https://go.dev/dl/go1.21.4.linux-amd64.tar.gz" \
    && tar -zxvf go.tar.gz \
    && mv go /usr/local/bin/go \
    && rm go.tar.gz

# Update NPM
RUN npm install -g npm
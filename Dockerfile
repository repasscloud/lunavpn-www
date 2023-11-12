# Use the Ubuntu base image
FROM node:slim

# Set the working directory
WORKDIR /app

# Update NPM
RUN [ npm install -g npm ]

# Install required packages and cleanup
RUN apt-get update && apt-get -y upgrade && apt-get install -y \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Hugo (extended)
COPY hugo /usr/local/bin/hugo

# Install Go
COPY go.tar.gz .
RUN [ tar -C /usr/local -xzf go.tar.gz ] \
    && rm -rf go.tar.gz

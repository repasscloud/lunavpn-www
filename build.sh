#!/usr/bin/env bash

# Download Hugoplate
curl -L -o main.zip https://github.com/zeon-studio/hugoplate/archive/refs/heads/main.zip \
    && unzip main.zip \
    && rm main.zip \
    && mv hugoplate-main/* .


#docker build --rm --no-cache -t myhugo .


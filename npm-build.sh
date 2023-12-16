#!/bin/bash

docker run --rm -v "$(pwd)/app:/app" myhugo /bin/bash -c "npm run build"

#!/bin/bash

docker run --rm -v "$(pwd)/app:/app" myhugo:10.4.0 /bin/bash -c "npm run build"

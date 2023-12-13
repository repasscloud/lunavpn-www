#!/bin/sh

# Stop the nginx container if it exists
if docker ps -a --format '{{.Names}}' | grep -q '^nginx$'; then
    docker stop nginx
fi

# Run your build script
./npm-build.sh

# Run Nginx container
docker run --rm -d -p 80:80 -v $(pwd)/app/public:/usr/share/nginx/html --name nginx nginx
echo "Runs on http://localhost:80/"

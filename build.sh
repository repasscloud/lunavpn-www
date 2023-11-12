#!/usr/bin/env bash

latest_version=$(curl -s "https://api.github.com/repos/gohugoio/hugo/tags" | jq -r '.[0].name')
latest_version_no_v=${latest_version#v}

docker build --rm --no-cache -t myhugo .

#docker run -it --rm myhugo sh


# npm run dev
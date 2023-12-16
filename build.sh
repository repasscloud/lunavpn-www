#!/bin/bash

# Get the CPU architecture
arch=$(uname -m)

# Run docker build per arch
if [ "$arch" = "aarch64" ]; then
    echo "This is an arm64 architecture."
elif [ "$arch" = "x86_64" ]; then
    echo "This is an amd64 (x86_64) architecture."
    docker build --rm --no-cache -f Dockerfile -t myhugo .
elif [ "$arch" = "arm64" ]; then
    echo "This is an arm64 architecture."
    docker build --rm --no-cache -f Dockerfile.arm64 -t myhugo .
else
    echo "Unsupported architecture: $arch"
    exit 1
fi

# Remove published folder
rm -rf ./app/public 

# Run your build script
./npm-build.sh

# Define the search and replace strings
search_string='<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#feffff" d="M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z"/></svg>'
replace_string='<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path fill="#feffff" d="M389.2 48h70.6L305.6 224.2 487 464H345L233.7 318.6 106.5 464H35.8L200.7 275.5 26.8 48H172.4L272.9 180.9 389.2 48zM364.4 421.8h39.1L151.1 88h-42L364.4 421.8z"/></svg>'

# Use find to locate and process files
find . -type f -exec sed -i "s|$search_string|$replace_string|g" {} +
echo "Text replacement complete."

# Generate sitemap.xml
# Check if Python or Python3 is installed
if command -v python &>/dev/null; then
    echo "Python is installed."
    python -m pip install beautifulsoup4
elif command -v python3 &>/dev/null; then
    echo "Python3 is installed."
    python3 -m pip install beautifulsoup4
else
    echo "Python or Python3 is not found. Please install Python and try again."
    exit 1
fi

# Verify the installation
if python -c "import bs4"; then
    echo "BeautifulSoup installation successful!"

    echo "Building sitemap.xml"
    python gen-sitemap.py
else
    echo "BeautifulSoup installation failed."
fi


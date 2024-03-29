#!/bin/sh

# Stop the nginx container if it exists
if docker ps -a --format '{{.Names}}' | grep -q '^nginx$'; then
    docker stop nginx
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
#python3 gen-sitemap.py

# Replace docs
rm -rf ./docs
mkdir docs
cp -r app/public/* ./docs/
mkdir -p ./docs/.well-known
cp ./apple-developer-merchantid-domain-association ./docs/.well-known/apple-developer-merchantid-domain-association
cp ./LunaVPN-Auth0-Logo.png ./docs/images/LunaVPN-Auth0-Logo.png
mkdir -p ./docs/images/faq-articles

# Update all offline images with webp
cp -r app/assets/images/faq-articles/* ./docs/images/faq-articles/
#!/bin/bash

# Directory containing the PNG files
DIR="./docs/images/faq-articles"

# Loop through each .png file in the specified directory
for i in "$DIR"/*.png; do
    # Skip if directory is empty
    [ -e "$i" ] || continue

    # Get the base file name without the path and the extension
    base=$(basename "$i" .png)

    # Output file with .webp extension
    output="$DIR/$base.webp"

    # Convert the file
    cwebp "$i" -o "$output"
done

# Run Nginx container
docker run --rm -d -p 80:80 -v $(pwd)/app/public:/usr/share/nginx/html --name nginx nginx
echo "Runs on http://localhost:80/"

# Update gh-repo
git add .
git commit -m 'server restart'
git push

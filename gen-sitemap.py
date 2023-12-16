import os
from bs4 import BeautifulSoup

def generate_sitemap(base_url, output_path):
    with open(output_path, 'w') as f:
        f.write('<?xml version="1.0" encoding="UTF-8"?>\n')
        f.write('<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n')

        # Iterate through your Hugo content directory and add URLs to the sitemap
        for root, dirs, files in os.walk('./app/public'):
            for file in files:
                if file.endswith('.html'):
                    # Construct the URL for each HTML file
                    url = os.path.relpath(os.path.join(root, file), './app/public')
                    url = url.replace('\\', '/')  # Convert backslashes to forward slashes
                    url = f'{base_url}/{url}'  # Prepend the base URL

                    # Extract information from the HTML file
                    with open(os.path.join(root, file), 'r', encoding='utf-8') as html_file:
                        soup = BeautifulSoup(html_file, 'html.parser')
                        title = soup.find('title').text
                        description_tag = soup.find('meta', attrs={'name': 'description'})
                        description = description_tag['content'] if description_tag else 'No description found'
                        keywords_tag = soup.find('meta', attrs={'name': 'keywords'})
                        keywords = keywords_tag['content'] if keywords_tag else 'No keywords found'
                        author_tag = soup.find('meta', attrs={'name': 'author'})
                        author = author_tag['content'] if author_tag else 'No author found'

                    # Write the URL and extracted information to the sitemap
                    f.write(f'  <url>\n')
                    f.write(f'    <loc>{url}</loc>\n')
                    f.write(f'    <title>{title}</title>\n')
                    f.write(f'    <description>{description}</description>\n')
                    f.write(f'    <keywords>{keywords}</keywords>\n')
                    f.write(f'    <author>{author}</author>\n')
                    f.write(f'  </url>\n')

        f.write('</urlset>\n')

if __name__ == '__main__':
    base_url = 'https://lunavpn.co'
    output_path = './app/public/sitemap.xml'
    generate_sitemap(base_url, output_path)

#!/bin/bash

file="app/assets/images/man1.jpg"
outfile="app/assets/images/man1-sm.jpg"
convert $file -crop 90%x90% $outfile


convert app/assets/images/man1-sm-0.jpg -resize 120x120 app/assets/images/avatar-mark-sm-120x120.jpg

# call restart server script
./restart-server.sh
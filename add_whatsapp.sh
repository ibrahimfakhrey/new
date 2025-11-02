#!/bin/bash

# Add WhatsApp icon to all HTML files
for file in $(find . -name "*.html" -type f | grep -v backup_en_files); do
    echo "Processing $file..."
    sed -i '' 's|<li><a href="https://www.instagram.com/mozoonalkhairsa" target="_blank"><i class="fab fa-instagram"></i></a></li>|<li><a href="https://www.instagram.com/mozoonalkhairsa" target="_blank"><i class="fab fa-instagram"></i></a></li>\
<li><a href="https://wa.me/966547700922" target="_blank"><i class="fab fa-whatsapp"></i></a></li>|g' "$file"
done

echo "WhatsApp icons added to all HTML files!"
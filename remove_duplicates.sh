#!/bin/bash

# Remove duplicate WhatsApp icons from all HTML files
for file in $(find . -name "*.html" -type f | grep -v backup_en_files); do
    echo "Removing duplicates from $file..."
    # Create a temporary file
    temp_file=$(mktemp)
    
    # Process the file to remove consecutive duplicate WhatsApp lines
    awk '
    /fa-whatsapp/ {
        if (prev_line ~ /fa-whatsapp/) {
            next
        }
    }
    { 
        print
        prev_line = $0
    }' "$file" > "$temp_file"
    
    # Replace the original file
    mv "$temp_file" "$file"
done

echo "Duplicate WhatsApp icons removed!"
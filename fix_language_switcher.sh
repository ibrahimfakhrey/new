#!/bin/bash

# Fix language switcher syntax errors and update Arabic links in English HTML files
for file in *-en.html; do
    if [ -f "$file" ]; then
        echo "Fixing language switcher in $file..."
        
        # Fix syntax error: add missing quote after index-en.html
        sed -i '' 's/href="index-en\.html>/href="index-en.html">/g' "$file"
        
        # Update Arabic language link to point to index.html instead of index-en.html
        sed -i '' 's/href="index-en\.html"><span><\/span>AR/href="index.html"><span><\/span>AR/g' "$file"
        
        echo "Fixed $file"
    fi
done

echo "Language switcher fixes completed!"

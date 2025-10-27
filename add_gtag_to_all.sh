#!/bin/bash

# Google Analytics gtag script to be added
GTAG_SCRIPT='<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-17631507239"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('\''js'\'', new Date());

  gtag('\''config'\'', '\''AW-17631507239'\'');
</script>'

# Find all HTML files and process them
find . -name "*.html" -type f | while read -r file; do
    echo "Processing: $file"
    
    # Check if gtag script already exists in the file
    if grep -q "gtag.js?id=AW-17631507239" "$file"; then
        echo "  - Gtag script already exists, skipping..."
        continue
    fi
    
    # Check if file has a </head> tag
    if grep -q "</head>" "$file"; then
        # Create a temporary file
        temp_file=$(mktemp)
        
        # Add gtag script before </head>
        sed "s|</head>|$GTAG_SCRIPT\n</head>|" "$file" > "$temp_file"
        
        # Replace original file with modified content
        mv "$temp_file" "$file"
        echo "  - Added gtag script successfully"
    else
        echo "  - No </head> tag found, skipping..."
    fi
done

echo "Gtag script addition completed!"
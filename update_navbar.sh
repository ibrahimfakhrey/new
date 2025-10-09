#!/bin/bash

# Script to update navigation links in English HTML files to point to English pages

# List of English HTML files
files=(
    "careers-en.html"
    "company-profile-en.html"
    "csr-en.html"
    "get-in-touch-en.html"
    "hard-services-en.html"
    "history-en.html"
    "index-en.html"
    "infrastructure-en.html"
    "leaders-message-en.html"
    "mission-vision-values-en.html"
    "news-events-en.html"
    "operational-excellence-en.html"
    "request-a-quote-en.html"
    "sectors-en.html"
    "soft-services-en.html"
    "specialist-services-en.html"
    "strategy-en.html"
    "testimonials-en.html"
)

# Navigation link mappings (Arabic -> English)
declare -A link_mappings=(
    ["index.html"]="index-en.html"
    ["company-profile.html"]="company-profile-en.html"
    ["leaders-message.html"]="leaders-message-en.html"
    ["history.html"]="history-en.html"
    ["mission-vision-values.html"]="mission-vision-values-en.html"
    ["strategy.html"]="strategy-en.html"
    ["operational-excellence.html"]="operational-excellence-en.html"
    ["infrastructure.html"]="infrastructure-en.html"
    ["csr.html"]="csr-en.html"
    ["hard-services.html"]="hard-services-en.html"
    ["soft-services.html"]="soft-services-en.html"
    ["specialist-services.html"]="specialist-services-en.html"
    ["sectors.html"]="sectors-en.html"
    ["testimonials.html"]="testimonials-en.html"
    ["careers.html"]="careers-en.html"
    ["news-events.html"]="news-events-en.html"
    ["get-in-touch.html"]="get-in-touch-en.html"
    ["request-a-quote.html"]="request-a-quote-en.html"
)

echo "Updating navigation links in English HTML files..."

# Update each file
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Processing $file..."
        
        # Create a backup
        cp "$file" "$file.backup"
        
        # Apply all the link replacements
        for arabic_link in "${!link_mappings[@]}"; do
            english_link="${link_mappings[$arabic_link]}"
            sed -i '' "s|href=\"$arabic_link\"|href=\"$english_link\"|g" "$file"
        done
        
        echo "Updated $file"
    else
        echo "Warning: $file not found"
    fi
done

echo "Navigation link updates completed!"
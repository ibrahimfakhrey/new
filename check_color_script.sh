#!/bin/bash

# Script to check for #04ACAA color instances in all HTML files
# Created to help identify remaining color replacements needed

echo "=== Checking for #04ACAA color instances in all HTML files ==="
echo "Date: $(date)"
echo "=============================================================="

# Counter for total instances
total_instances=0
files_with_color=0

# Find all HTML files and check for #04ACAA
while IFS= read -r -d '' file; do
    # Count instances in this file
    count=$(grep -c "#04ACAA" "$file" 2>/dev/null)
    if [ $? -ne 0 ]; then
        count=0
    fi
    
    if [ "$count" -gt 0 ]; then
        echo ""
        echo "File: $file"
        echo "Instances found: $count"
        echo "Lines containing #04ACAA:"
        grep -n "#04ACAA" "$file" | head -5  # Show first 5 matches
        if [ "$count" -gt 5 ]; then
            echo "... and $((count - 5)) more instances"
        fi
        echo "----------------------------------------"
        
        total_instances=$((total_instances + count))
        files_with_color=$((files_with_color + 1))
    fi
done < <(find /Users/ibrahimfakhry/Desktop/new -name "*.html" -type f -print0)

echo ""
echo "=== SUMMARY ==="
echo "Files containing #04ACAA: $files_with_color"
echo "Total instances found: $total_instances"
echo ""

if [ "$total_instances" -eq 0 ]; then
    echo "✅ SUCCESS: No #04ACAA color instances found in any HTML files!"
else
    echo "⚠️  WARNING: $total_instances instances of #04ACAA still need to be replaced with #FF8C42"
    echo ""
    echo "To replace all instances, run:"
    echo "find /Users/ibrahimfakhry/Desktop/new -name '*.html' -type f -exec sed -i '' 's/#04ACAA/#FF8C42/g' {} +"
fi

echo "=============================================================="
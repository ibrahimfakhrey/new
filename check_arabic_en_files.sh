#!/bin/bash

echo "=== COMPREHENSIVE ARABIC TEXT CHECK FOR EN.HTML FILES ==="
echo "Date: $(date)"
echo "Directory: $(pwd)"
echo

total_files=0
files_with_arabic=0
total_arabic_chars=0

# Array to store files with Arabic content
declare -a files_with_arabic_content

echo "Checking all *en.html files (excluding backup_en_files)..."
echo "================================================================"

for file in $(find . -name "*en.html" -type f | grep -v backup_en_files | sort); do
    total_files=$((total_files + 1))
    echo "[$total_files] Checking: $file"
    
    # Count Arabic characters
    count=$(grep -o "[\u0600-\u06FF]" "$file" 2>/dev/null | wc -l | tr -d ' ')
    
    if [ "$count" -gt 0 ]; then
        files_with_arabic=$((files_with_arabic + 1))
        total_arabic_chars=$((total_arabic_chars + count))
        files_with_arabic_content+=("$file:$count")
        
        echo "  ❌ ARABIC FOUND: $count characters"
        echo "  📝 Sample lines with Arabic content:"
        grep -n "[\u0600-\u06FF]" "$file" | head -3 | sed 's/^/     /'
        echo
    else
        echo "  ✅ CLEAN: No Arabic characters found"
        echo
    fi
done

echo "================================================================"
echo "SUMMARY REPORT"
echo "================================================================"
echo "Total files checked: $total_files"
echo "Files with Arabic content: $files_with_arabic"
echo "Files without Arabic content: $((total_files - files_with_arabic))"
echo "Total Arabic characters found: $total_arabic_chars"
echo

if [ $files_with_arabic -gt 0 ]; then
    echo "FILES REQUIRING TRANSLATION:"
    echo "----------------------------"
    for item in "${files_with_arabic_content[@]}"; do
        file=$(echo "$item" | cut -d: -f1)
        count=$(echo "$item" | cut -d: -f2)
        echo "• $file ($count Arabic characters)"
    done
    echo
    echo "NEXT STEPS:"
    echo "1. Review each file listed above"
    echo "2. Translate Arabic text to English"
    echo "3. Verify translations are contextually appropriate"
    echo "4. Test each page after translation"
else
    echo "🎉 ALL FILES ARE CLEAN! No Arabic text found in any en.html files."
fi

echo
echo "Script completed at: $(date)"
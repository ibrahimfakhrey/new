#!/bin/bash

# Replace old working hours text with new text in all HTML files
# Old text: ايام العمل من الاحد الي الخميس من ٨ الي ٤ م ماعدا السبت من ١ ظهرا الي ٤ م
# New text: ايام العمل من السبت الي الخميس  من ٨ صباحا الي ٥ مساءا

OLD_TEXT="ايام العمل من الاحد الي الخميس من ٨ الي ٤ م ماعدا السبت من ١ ظهرا الي ٤ م"
NEW_TEXT="ايام العمل من السبت الي الخميس  من ٨ صباحا الي ٥ مساءا"

# Find all HTML files and replace the text
find . -name "*.html" -type f -exec sed -i '' "s/${OLD_TEXT}/${NEW_TEXT}/g" {} \;

echo "Working hours text has been updated in all HTML files."
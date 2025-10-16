#!/bin/bash

# List of Arabic HTML files to update
files=(
    "./infrastructure.html"
    "./strategy.html"
    "./testimonials.html"
    "./operational-excellence.html"
    "./sectors.html"
    "./general-construction.html"
    "./business-management.html"
    "./get-in-touch.html"
    "./leaders-message.html"
    "./careers.html"
    "./csr.html"
    "./request-a-quote.html"
    "./news-events.html"
    "./history.html"
    "./facilities-management.html"
    "./mission-vision-values.html"
    "./hard-services.html"
    "./specialist-services.html"
    "./soft-services.html"
    "./company-profile.html"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Updating $file..."
        
        # Create a temporary file for processing
        temp_file=$(mktemp)
        
        # Process the file line by line
        while IFS= read -r line; do
            # Check if this is the About Us footer section
            if [[ "$line" == *'<ul class="footer-menu"><h5>حولنا </h5></ul><ul class="footer-menu"><div class="menu-about-us-container"><ul class="menu" id="menu-about-us"><li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-130" id="menu-item-130"><a href="company-profile.html">بروفايل الشركة</a></li>'* ]]; then
                # Replace the entire About Us section with simplified version
                echo '<ul class="footer-menu"><h5>حولنا </h5></ul><ul class="footer-menu"><div class="menu-about-us-container"><ul class="menu" id="menu-about-us"><li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-130" id="menu-item-130"><a href="company-profile.html">من نحن</a></li>' >> "$temp_file"
                # Skip the next 5 lines (the detailed sub-items)
                for i in {1..5}; do
                    read -r
                done
            elif [[ "$line" == *'<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-131" id="menu-item-131"><a href="get-in-touch.html">تواصل معنا</a></li>'* ]] && ! grep -q "أطلب الأسعار" "$file"; then
                # Add the contact us line and the request quote line
                echo "$line" >> "$temp_file"
                echo '<li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-132" id="menu-item-132"><a href="request-a-quote.html">أطلب الأسعار</a></li>' >> "$temp_file"
            else
                echo "$line" >> "$temp_file"
            fi
        done < "$file"
        
        # Replace the original file with the processed one
        mv "$temp_file" "$file"
        
        echo "Updated $file"
    else
        echo "File $file not found, skipping..."
    fi
done

echo "All Arabic HTML files updated!"

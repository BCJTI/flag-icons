#!/bin/bash

# Check for correct usage
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <output_extension>"
    echo "Example: $0 png"
    echo "Example: $0 jpg"
    exit 1
fi

# Get the output extension from the argument
output_ext="$1"

# Validate the output extension
if [[ "$output_ext" != "png" && "$output_ext" != "jpg" ]]; then
    echo "Error: Unsupported output extension. Please use 'png' or 'jpg'."
    exit 1
fi

# Find all .svg files and process them
find . -type f -name "*.svg" | while read -r file; do
    # Temporary PNG output file
    temp_output="${file%.svg}.png"

    # Final output file with the requested extension
    final_output="${file%.svg}.$output_ext"

    # Convert the SVG to PNG using Inkscape
    inkscape -z -w 21 -h 16 "$file" -e "$temp_output"

    # If the output extension is jpg, convert the PNG to JPG
    if [ "$output_ext" == "jpg" ]; then
        # Use ImageMagick to convert PNG to JPG
        convert "$temp_output" "$final_output"
        # Remove the temporary PNG file
        rm -f "$temp_output"
    fi
done


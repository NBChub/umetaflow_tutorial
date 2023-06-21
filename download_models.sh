#!/bin/bash

# Specify the default folder where the files will be downloaded
default_folder="snakemake_UmetaFlow/resources/ms2query"

# Help function
function display_help {
    echo "Usage: script.sh <file> [folder]"
    echo "Download files from URLs listed in the specified file."
    echo ""
    echo "Arguments:"
    echo "  file    : The file containing the URLs to download."
    echo "  folder  : (Optional) The folder where the files will be downloaded. Default: $default_folder"
    echo ""
}

# Check if help option is provided
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    display_help
    exit 0
fi

# Specify the folder where the files will be downloaded
folder="${2:-$default_folder}"

# Read the file containing the URLs
file="$1"

# Create the download folder if it doesn't exist
mkdir -p "$folder"

# Download each URL using wget
while IFS= read -r url; do
    wget -P "$folder" "$url"
done < "$file"

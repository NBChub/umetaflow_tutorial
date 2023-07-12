#!/bin/bash

# Specify the default folder where all the binaries will be downloaded
default_folder="resources/"

# Help function
function display_help {
    echo "Usage: script.sh [options]"
    echo "Download resources required for running umetaflow."
    echo ""
    echo "Options:"
    echo "-f, --folder <folder>       (Optional) The folder where the files will be downloaded. Default: $default_folder"
    echo "-o, --MY_OS <MY_OS>         (Optional) The operating system that is used ('osx64' for macOS and 'linux64' for Linux). Default: $default_MY_OS"
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

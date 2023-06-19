#!/bin/bash

# Specify the default folder where the files will be downloaded
default_folder="resources"

# Help function
function display_help {
    echo "Usage: script.sh [folder]"
    echo "Download resources required for running umetaflow."
    echo ""
    echo "Arguments:"
    echo "  folder  : (Optional) The folder where the files will be downloaded. Default: $default_folder"
    echo ""
}

# Check if help option is provided
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    display_help
    exit 0
fi

# Specify the folder where the files will be downloaded
folder=${1:-$default_folder}

# get sirius binary
sirius_binary="https://github.com/boecker-lab/sirius/releases/download/v5.7.3/sirius-5.7.3-linux64.zip"

wget -P $folder $sirius_binary -nc
unzip -u $folder/*.zip -d $folder

# Get the directory of the current script
script_directory=$(dirname "$0")
echo $script_directory
bash $script_directory/download_models.sh $script_directory/zenodo_positive.txt
bash $script_directory/download_models.sh $script_directory/zenodo_negative.txt
#!/bin/bash

# Specify the default folder where the files will be downloaded
default_folder="snakemake_UmetaFlow/resources"
default_mode="positive"
default_OS="osx64"

# Help function
function display_help {
    echo "Usage: script.sh [folder]"
    echo "Download resources required for running umetaflow."
    echo ""
    echo "Arguments:"
    echo "folder:         (Optional) The folder where the files will be downloaded. Default: $default_folder"
    echo "ion_mode:       (Optional) The ionization mode of the data ("positive" or "negative"). Default: $default_mode"
    echo "MY_OS:          (Optional) The operating system that is used ("osx64" for macOS and "linux64" for linux). Default: $default_OS"
    echo ""
}

# Check if help option is provided
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    display_help
    exit 0
fi

# Specify the folder where the files will be downloaded
folder=${1:-$default_folder}

# Specify the ion mode
ion_mode=${1:-$default_mode}

# Specify the operating system
MY_OS=${1:-$default_OS}

# get the SIRIUS executable
(cd ${default_folder} && curl -s https://api.github.com/repos/boecker-lab/sirius/releases/latest | tr -d '"' | grep "browser_download_url.*${MY_OS}.zip$"| cut -d : -f 2,3 |  wget -i- && unzip *.zip)

# get the ThermoRawFileParser executable
(mkdir ${default_folder}/ThermoRawFileParser && cd ${default_folder}/ThermoRawFileParser && wget https://github.com/compomics/ThermoRawFileParser/releases/download/v1.3.4/ThermoRawFileParser.zip && unzip ThermoRawFileParser.zip)

# Get the directory of the current script
script_directory=$(dirname "$0")
echo $script_directory
bash $script_directory/download_models.sh $script_directory/zenodo_${default_mode}.txt

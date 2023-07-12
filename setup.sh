#!/bin/bash

# Specify the default folder where the files will be downloaded
default_folder="resources"
default_OS="linux64"

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

# Default option values
folder=$default_folder
MY_OS=$default_MY_OS

# Parse command-line options
while getopts ":f:m:o:-:" opt; do
    case $opt in
        f) folder=$OPTARG ;;
        m) ion_mode=$OPTARG ;;
        o) MY_OS=$OPTARG ;;
        -)
            case $OPTARG in
                folder) folder="${!OPTIND}" ;;
                MY_OS) MY_OS="${!OPTIND}" ;;
                help) display_help; exit 0 ;;
                *) echo "Invalid option: --$OPTARG"; exit 1 ;;
            esac
            OPTIND=$((OPTIND + 1))
            ;;
        \?) echo "Invalid option: -$OPTARG"; exit 1 ;;
        :) echo "Option -$OPTARG requires an argument."; exit 1 ;;
    esac
done

# Get the SIRIUS executable
(mkdir -p  "$folder" && cd "$folder" && curl -s "https://api.github.com/repos/boecker-lab/sirius/releases/latest" | tr -d '"' | grep "browser_download_url.*${MY_OS}.zip$" | cut -d : -f 2,3 | wget -i- && unzip *.zip)

# Get the ThermoRawFileParser executable
(mkdir -p "$folder/ThermoRawFileParser" && cd "$folder/ThermoRawFileParser" && wget "https://github.com/compomics/ThermoRawFileParser/releases/download/v1.3.4/ThermoRawFileParser.zip" && unzip ThermoRawFileParser.zip)

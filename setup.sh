#!/bin/bash

# get sirius binary
sirius_binary="https://github.com/boecker-lab/sirius/releases/download/v5.7.3/sirius-5.7.3-linux64.zip"
folder="resources"
wget -P $folder $sirius_binary -nc
unzip -u $folder/*.zip -d $folder

bash download_models.sh zenodo_positive.txt 
bash download_models.sh zenodo_negative.txt 

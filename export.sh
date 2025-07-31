#!/bin/bash
echo "Parse and export markdown file for github wiki"

# Create export folder if not exist
mkdir -p "export"

# Get repo path
PATH_REPO="$( git config --get remote.origin.url | sed 's/rF2ModdingNotes.git/rF2ModdingNotes/' )"
echo -e "REPO PATH: ${PATH_REPO}\n"

# Set & replace image path
PATH_REL=$(echo "../images/" | sed 's/\//\\\//g')
PATH_ABS=$(echo "${PATH_REPO}/raw/master/images/" | sed 's/\//\\\//g')

# Export files to ./export folder
for SOURCE_MD in src/*.md;
do
    echo "SOURCE: ${SOURCE_MD}"
    EXPORT_PATH=$(echo "./export/${SOURCE_MD}" | sed 's/src\///')
    cp ${SOURCE_MD} ${EXPORT_PATH}
    sed -i "s/$PATH_REL/$PATH_ABS/" ${EXPORT_PATH}
    echo -e "EXPORT: ${EXPORT_PATH}\n"
done

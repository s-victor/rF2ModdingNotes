#!/bin/bash
echo -e "Parse and export markdown file for github wiki\n"

# Set export path
if [ -n "$1" ]
then
    # export path from argument
    FOLDER_PATH="$1"
else
    # default path
    FOLDER_PATH="export"
fi

# Create export folder if not exist
mkdir -p ${FOLDER_PATH}

# Get repo raw content path
PATH_REPO="$( git config --get remote.origin.url | sed 's/github.com/raw.githubusercontent.com/' | sed 's/rF2ModdingNotes.git/rF2ModdingNotes/' )"
echo -e "REPO RAW PATH: ${PATH_REPO}\n"

# Set & replace image path
PATH_REL=$(echo "../images/" | sed 's/\//\\\//g')
PATH_ABS=$(echo "${PATH_REPO}/master/images/" | sed 's/\//\\\//g')

# Export files to export folder
for SOURCE_MD in src/*.md;
do
    echo "SOURCE: ${SOURCE_MD}"
    EXPORT_PATH=$(echo "${FOLDER_PATH}/${SOURCE_MD}" | sed 's/src\///')
    cp ${SOURCE_MD} ${EXPORT_PATH}
    sed -i "s/$PATH_REL/$PATH_ABS/" ${EXPORT_PATH}
    echo -e "EXPORT: ${EXPORT_PATH}\n"
done

echo "Generate Table of Content"
echo "" >> "${FOLDER_PATH}/Home.md"
cat "src/_Sidebar.md" >> "${FOLDER_PATH}/Home.md"
echo "EXPORT: ${FOLDER_PATH}/Home.md"

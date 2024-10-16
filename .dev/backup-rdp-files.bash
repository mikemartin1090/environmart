#! /usr/bin/env bash

# This script backs up the Microsoft Remote Desktop Connection files
# Inspired by: https://learn.microsoft.com/en-us/answers/questions/396874/how-to-copy-setup-of-remote-desktop-for-mac-to-a-n

# Define backup destination directory
BACKUP_DIR="$HOME/MicrosoftRDC_Backups"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Define the source directory where RDC files are stored
SOURCE_DIR="$HOME/Library/Containers/com.microsoft.rdc.macos/Data/Library/Application Support/com.microsoft.rdc.macos"

# Define the files to back up
FILES=(
    "com.microsoft.rdc.application-data.sqlite"
    "com.microsoft.rdc.application-data.sqlite-shm"
    "com.microsoft.rdc.application-data.sqlite-wal"
)

# Copy each file to the backup destination
for FILE in "${FILES[@]}"; do
    if [ -f "$SOURCE_DIR/$FILE" ]; then
        cp "$SOURCE_DIR/$FILE" "$BACKUP_DIR/"
        echo "Backed up $FILE to $BACKUP_DIR"
    else
        echo "File $FILE not found in $SOURCE_DIR"
    fi
done

echo "Backup completed!"

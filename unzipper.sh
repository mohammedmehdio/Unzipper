#!/bin/bash

# Usage: ./unziper data.txt
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILE="$1"
NAME="current_file"

# --- Step 1: Handle the Hexdump ---
echo "Checking if input is a hexdump..."
if file "$FILE" | grep -q "ASCII text"; then
    echo "Reversing Hexdump..."
    xxd -r "$FILE" > "$NAME"
else
    cp "$FILE" "$NAME"
fi

# --- Step 2: The Main Loop ---
while true; do
    FILE_TYPE=$(file "$NAME")
    
    if [[ "$FILE_TYPE" == *"ASCII text"* ]]; then
        echo "--------------------------------"
        echo "FOUND IT! The password is:"
        echo "--------------------------------"
        cat "$NAME"
        echo "" 
        break

    elif [[ "$FILE_TYPE" == *"gzip compressed data"* ]]; then
        echo "Type: GZIP. Decompressing..."
        mv "$NAME" "$NAME.gz"
        gzip -d "$NAME.gz"

    elif [[ "$FILE_TYPE" == *"bzip2 compressed data"* ]]; then
        echo "Type: BZIP2. Decompressing..."
        mv "$NAME" "$NAME.bz2"
        bzip2 -d "$NAME.bz2"

    elif [[ "$FILE_TYPE" == *"tar archive"* ]]; then
        echo "Type: TAR. Extracting..."
        mv "$NAME" "archive.tar"
        
        # FIX: Ask the tarball what filename is inside it using -tf
        # This avoids confusing it with other files in your folder.
        INSIDE_FILE=$(tar -tf "archive.tar" | head -n 1)
        
        tar -xf "archive.tar"
        
        # Move that specific file to be our working file
        mv "$INSIDE_FILE" "$NAME"
        
        rm "archive.tar"
        
    else
        echo "Error: Unknown file type."
        echo "$FILE_TYPE"
        break
    fi
done

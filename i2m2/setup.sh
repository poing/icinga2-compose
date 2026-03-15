#!/bin/sh

# Define source and destination files
SOURCE_DIR="/mnt/i2m1/ca/"
DEST_DIR="/var/lib/icinga2/ca/"

SOURCE_CRT="${SOURCE_DIR}ca.crt"
SOURCE_KEY="${SOURCE_DIR}ca.key"
DEST_CRT="${DEST_DIR}ca.crt"
DEST_KEY="${DEST_DIR}ca.key"

# Function to check and sync CA certificate and key
sync_ca_files() {
    # Check if the source files exist
    if [ ! -f "$SOURCE_CRT" ]; then
        echo "Source CA certificate not found: $SOURCE_CRT"
        echo "Did you run setup.sh and restart the i2m1 container?"
        exit 1
    fi

    if [ ! -f "$SOURCE_KEY" ]; then
        echo "Source CA key not found: $SOURCE_KEY"
        exit 1
    fi

    # Compare CA certificate and key with destination
    if ! cmp -s "$SOURCE_CRT" "$DEST_CRT" || ! cmp -s "$SOURCE_KEY" "$DEST_KEY"; then
        echo "Files do not match. Copying to shared location..."
        cp "$SOURCE_CRT" "$DEST_CRT"
        cp "$SOURCE_KEY" "$DEST_KEY"

        echo "Files copied successfully."
        sudo rm /var/lib/icinga2/certs/*
        echo "First step complete."
        echo "Restart the container. You need to run setup.sh again!"
    else
        echo "Files match. No action required."
        icinga2 node wizard
        update_icinga2_config 
    fi

}

# Function to update icinga2 configuration
update_icinga2_config() {
    echo "Updating Icinga2 configuration..."
    sudo rm -rf /etc/icinga2
    sudo ln -sv /mnt/i2m2/etc /etc/icinga2 > /dev/null
    echo "Restart the container.  Setup of i2m2 is complete."
}

# Execute functions
sync_ca_files



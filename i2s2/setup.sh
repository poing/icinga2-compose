#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check and sync CA certificate and key
sync_ca_files() {

    # Define source and destination files
    SOURCE_DIR="/mnt/icinga2-compose/i2m1/ca/"
    DEST_DIR="/var/lib/icinga2/ca/"

    SOURCE_CRT="${SOURCE_DIR}ca.crt"
    SOURCE_KEY="${SOURCE_DIR}ca.key"
    DEST_CRT="${DEST_DIR}ca.crt"
    DEST_KEY="${DEST_DIR}ca.key"

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

# Function to check if /etc/icinga/ is using the read-only symlink
check_icinga2_config_writable() {
    # Define the file to check
    ZONE_FILE="/etc/icinga2/zones.conf"

    # Check if the file exists
    if [ ! -f "$ZONE_FILE" ]; then
        echo "File $ZONE_FILE does not exist."
        exit 1
    fi

    # Check file permissions
    if [ -r "$ZONE_FILE" ] && [ ! -w "$ZONE_FILE" ]; then
        echo -e "${GREEN}Icinga2 configuration is read-only.${NC}"
    else
        icinga2 node wizard
        update_icinga2_config
    fi
}

# Function to update icinga2 configuration
update_icinga2_config() {
    echo -e "${BLUE}Updating Icinga2 configuration...${NC}"
    sudo rm -rf /etc/icinga2
    sudo ln -sv /mnt/icinga2 /etc/icinga2 > /dev/null
    echo -e "${GREEN}Setup of i2s2 is complete.${NC}"
    echo -e "${RED}Restart the container!${NC}"
}

# Execute functions
#sync_ca_files
#icinga2 node wizard
#update_icinga2_config
check_icinga2_config_writable

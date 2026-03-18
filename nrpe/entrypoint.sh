#!/bin/sh

# Define the path for the NRPE PID file
NRPE_PID="/var/run/nrpe.pid"

# Check if the NRPE PID file exists
if [ -f "$NRPE_PID" ]; then
  echo "entrypoing.sh: Removing stale NRPE PID file"
  rm "$NRPE_PID"  # Remove the stale PID file to avoid conflicts
fi
 
# Create or touch the NRPE log file to ensure it exists
touch /var/log/nrpe.log

# Start the NRPE service in the background with the specified configuration
/usr/bin/nrpe -c /etc/nrpe.cfg -f -d

# Continuously tail the NRPE log file to keep the container running
exec tail -n 0 -f /var/log/nrpe.log

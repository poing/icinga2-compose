#!/bin/sh

cp -r /usr/lib/nagios/plugins /shared_plugins/


# Continuously tail a log file to keep the container running
exec tail -n 0 -f /var/log/btmp

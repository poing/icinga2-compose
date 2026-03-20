# Dockerfile.plugins
FROM debian:12

# Install monitoring plugins
RUN apt-get update && \
    apt-get install -y monitoring-plugins-contrib nagios-nrpe-plugin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the plugins to a shared directory
#RUN mkdir /shared_plugins
#RUN cp -r /usr/lib/nagios/plugins /shared_plugins/


COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


# Set the entrypoint if needed
ENTRYPOINT ["./entrypoint.sh"]

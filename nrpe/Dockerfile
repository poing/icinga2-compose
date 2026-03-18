# Inspired by https://github.com/mikenowak/docker-nrpe

FROM alpine

RUN apk add --no-cache \
    monitoring-plugins \
    nagios-plugins-all \
    nrpe \
    # perl \
    sudo \
    # python3 \
    # ruby \
    bash \
    # skopeo \
    && echo 'nagios ALL=(ALL) NOPASSWD: /usr/lib/monitoring-plugins/*' >> /etc/sudoers \
    && echo 'Defaults: nagios !requiretty' >> /etc/sudoers

COPY nrpe.cfg /etc/nrpe.cfg

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5666

ENTRYPOINT ["./entrypoint.sh"]


FROM zabbix/zabbix-server-mysql:6.2-alpine-latest
LABEL maintainer="Chris Ruettimann <chris@bitbull.ch>"

# keep this from underlying container
ARG VERSION=6.2-alpine-latest
ARG APK_FLAGS_COMMON=""
ARG APK_FLAGS_PERSISTENT="${APK_FLAGS_COMMON} --clean-protected --no-cache"
ARG APK_FLAGS_DEV="${APK_FLAGS_COMMON} --no-cache"

USER root
# show version info
RUN echo "zabbix/zabbix-server-mysql:$VERSION" > /etc/zabbix-version

# add needed software
RUN apk add ${APK_FLAGS_DEV} bind-tools nmap curl iftop openssl bc jq

RUN setcap cap_net_raw,cap_net_admin+ep /usr/sbin/fping

# add essential software :-)
RUN apk add ${APK_FLAGS_DEV} vim

# enable and allow sudo
RUN apk add ${APK_FLAGS_DEV} sudo && echo 'zabbix ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# keep this from underlying container
EXPOSE 10051/TCP

# keep this from underlying container
VOLUME ["/usr/lib/zabbix/alertscripts", "/usr/lib/zabbix/externalscripts", "/var/lib/zabbix/enc", "/var/lib/zabbix/mibs", "/var/lib/zabbix/modules"]
VOLUME ["/var/lib/zabbix/snmptraps", "/var/lib/zabbix/ssh_keys", "/var/lib/zabbix/ssl/certs", "/var/lib/zabbix/ssl/keys", "/var/lib/zabbix/ssl/ssl_ca"]
VOLUME ["/var/lib/zabbix/export"]

# keep this from underlying container
ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/docker-entrypoint.sh"]
USER 1997
CMD ["/usr/sbin/zabbix_server", "--foreground", "-c", "/etc/zabbix/zabbix_server.conf"]

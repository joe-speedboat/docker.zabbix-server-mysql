FROM zabbix/zabbix-server-mysql:alpine-4.0.3
LABEL maintainer="Chris Ruettimann <chris@bitbull.ch>"

# keep this from underlying container
ARG APK_FLAGS_COMMON=""
ARG APK_FLAGS_PERSISTENT="${APK_FLAGS_COMMON} --clean-protected --no-cache"
ARG APK_FLAGS_DEV="${APK_FLAGS_COMMON} --no-cache"

# show version info
RUN echo "zabbix/zabbix-server-mysql:alpine-4.0.3" > /etc/zabbix-version

# add needed software
RUN apk add ${APK_FLAGS_DEV} bind-tools nmap curl iftop

# enable and allow sudo
RUN apk add ${APK_FLAGS_DEV} sudo && echo 'zabbix ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# keep this from underlying container
EXPOSE 10051/TCP

# keep this from underlying container
VOLUME ["/usr/lib/zabbix/alertscripts", "/usr/lib/zabbix/externalscripts", "/var/lib/zabbix/enc", "/var/lib/zabbix/mibs", "/var/lib/zabbix/modules"]
VOLUME ["/var/lib/zabbix/snmptraps", "/var/lib/zabbix/ssh_keys", "/var/lib/zabbix/ssl/certs", "/var/lib/zabbix/ssl/keys", "/var/lib/zabbix/ssl/ssl_ca"]

# keep this from underlying container
ENTRYPOINT ["docker-entrypoint.sh"]

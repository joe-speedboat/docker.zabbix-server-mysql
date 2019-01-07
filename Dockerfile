FROM zabbix/zabbix-server-mysql:alpine-4.0.3
LABEL maintainer="Chris Ruettimann <chris@bitbull.ch>"

ARG APK_FLAGS_COMMON=""
ARG APK_FLAGS_PERSISTENT="${APK_FLAGS_COMMON} --clean-protected --no-cache"
ARG APK_FLAGS_DEV="${APK_FLAGS_COMMON} --no-cache"

RUN apk add ${APK_FLAGS_DEV} --virtual \
		bind-tools \
		curl

EXPOSE 10051/TCP

VOLUME ["/usr/lib/zabbix/alertscripts", "/usr/lib/zabbix/externalscripts", "/var/lib/zabbix/enc", "/var/lib/zabbix/mibs", "/var/lib/zabbix/modules"]
VOLUME ["/var/lib/zabbix/snmptraps", "/var/lib/zabbix/ssh_keys", "/var/lib/zabbix/ssl/certs", "/var/lib/zabbix/ssl/keys", "/var/lib/zabbix/ssl/ssl_ca"]

ENTRYPOINT ["docker-entrypoint.sh"]

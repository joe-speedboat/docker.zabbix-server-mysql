#!/bin/sh -e
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
VERSION=6.0-alpine-latest
IMAGE=zabbix-server-mysql
FROM="zabbix/$IMAGE"
TO="christian773/$IMAGE"


cd $(dirname $0) 
docker system prune -a -f
sed -i "s@^FROM .*@FROM $FROM:$VERSION@" Dockerfile
sed -i "s@^ARG VERSION=.*@ARG VERSION=$VERSION@" Dockerfile

for V in $VERSION alpine-latest
do
   cd $(dirname $0) 
   docker build -t $IMAGE:$V .
   docker tag $IMAGE:$V $TO:$V
   docker push $TO:$V
done


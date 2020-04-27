#!/bin/sh -e
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
VERSION=alpine-4.4.7
IMAGE=zabbix-server-mysql
FROM="zabbix/$IMAGE"
TO="christian773/$IMAGE"

for V in alpine-latest $VERSION
do
   cd $(dirname $0) 
   docker system prune -a -f

   sed -i "s@^FROM .*@FROM $FROM:$V@" Dockerfile
   sed -i "s@^ARG VERSION=.*@ARG VERSION=$V@" Dockerfile

   docker build -t $IMAGE:$V .
   docker tag $IMAGE:$V $TO:$V
   docker push $TO
done


#!/bin/sh -e
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
VERSION=alpine-latest
IMAGE=zabbix-server-mysql

cd $(dirname $0) 

docker build -t $IMAGE:$VERSION .
docker tag $IMAGE:$VERSION christian773/zabbix-server-mysql:alpine-latest
docker push christian773/zabbix-server-mysql:alpine-latest


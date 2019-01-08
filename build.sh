#!/bin/sh -e
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
VERSION=alpine-4.0.3
IMAGE=zabbix-server-mysql

cd $(dirname $0) 

docker build -t $IMAGE:$VERSION .

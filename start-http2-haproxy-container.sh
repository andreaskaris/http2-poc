#!/bin/bash

if ! podman ps | grep -q http2-server ; then
	exit "ERROR: No container http2-server."
	exit 1
fi

SERVER_IP=$(podman inspect -f "{{.NetworkSettings.IPAddress}}" http2-server)
if [ "$SERVER_IP" == "" ]; then
	echo "ERROR: Cannot determine http2-server IP"
	exit 1
fi

podman run -e SERVER_IP=${SERVER_IP} -p 8083:8083 -p 8084:8084 -p 8085:8085 --name http2-haproxy -d ${REGISTRY}/http2-haproxy

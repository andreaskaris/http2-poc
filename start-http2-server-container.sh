#!/bin/bash

podman run -p 8080:8080 -p 8081:8081 -p 8082:8082 --name http2-server -d ${REGISTRY}/http2-server

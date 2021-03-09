#!/bin/bash


yum install haproxy -y
yum install wireshark -y
yum install iproute -y

cp /cert /etc/pki/ca-trust/source/anchors/
update-ca-trust extract
mkdir -p /etc/haproxy/certs/
cat /cert /key > /etc/haproxy/certs/pem
chown haproxy -R /etc/haproxy/certs/


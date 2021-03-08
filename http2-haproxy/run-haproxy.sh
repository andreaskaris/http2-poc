#!/bin/bash

SERVER=${SERVER:-localhost}
SERVER_HTTP_PORT=${SERVER_HTTP_PORT:-8080}
SERVER_H2C_PORT=${SERVER_H2C_PORT:-8081}
SERVER_H2_PORT=${SERVER_H2_PORT:-8082}
FRONTEND_HTTP_PORT=${FRONTEND_HTTP_PORT:-8083}
FRONTEND_H2C_PORT=${FRONTEND_H2C_PORT:-8084}
FRONTEND_H2_PORT=${FRONTEND_H2_PORT:-8085}
cat <<EOF > /etc/haproxy/haproxy.cfg 
global 
    log         127.0.0.1 local2 
 
    chroot      /var/lib/haproxy 
    pidfile     /var/run/haproxy.pid 
    maxconn     4000 
    user        haproxy 
    group       haproxy 
    daemon 
 
    # turn on stats unix socket 
    stats socket /var/lib/haproxy/stats 
 
    # utilize system-wide crypto-policies 
    ssl-default-bind-ciphers PROFILE=SYSTEM 
    ssl-default-server-ciphers PROFILE=SYSTEM 
 
defaults 
    mode                    http 
    log                     global 
    option                  httplog 
    option                  dontlognull 
    option http-server-close 
    option forwardfor       except 127.0.0.0/8 
    option                  redispatch 
    retries                 3 
    timeout http-request    10s 
    timeout queue           1m 
    timeout connect         10s 
    timeout client          1m 
    timeout server          1m 
    timeout http-keep-alive 10s 
    timeout check           10s 
    maxconn                 3000 
 
frontend fe_http1 
    mode http 
    bind *:$FRONTEND_HTTP_PORT
    default_backend be_http1 
 
backend be_http1 
    mode http 
    server server1 $SERVER_IP:$SERVER_HTTP_PORT
 
frontend fe_h2c 
    mode http 
    bind *:$FRONTEND_H2C_PORT proto h2 
    default_backend be_h2c 
 
backend be_h2c 
    mode http 
    server server1 $SERVER_IP:$SERVER_H2C_PORT proto h2 
 
frontend fe_h2 
    mode http 
    bind *:$FRONTEND_H2_PORT ssl crt /etc/haproxy/certs/pem alpn h2,http/1.1 
    default_backend be_h2 
 
backend be_h2 
    mode http 
    server server1 $SERVER_IP:$SERVER_H2_PORT ssl verify none alpn h2 
 
EOF

/usr/sbin/haproxy -Ws -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid


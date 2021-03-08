#!/bin/bash

yum install httpd -y
yum install mod_ssl -y
yum install which procps-ng -y
yum install openssl -y

rm -f /etc/httpd/conf.d/ssl.conf /root

cp /cert /etc/httpd/.
cp /key /etc/httpd/.
cp /cert /etc/pki/ca-trust/source/anchors/
update-ca-trust extract

mkdir -p /var/www/html{1,2,3} 

echo "HTTP (http)" > /var/www/html1/index.html
echo "HTTP/2 insecure (h2c)" > /var/www/html2/index.html
echo "HTTP/2 secure (h2)" > /var/www/html3/index.html

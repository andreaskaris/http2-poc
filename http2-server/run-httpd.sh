#!/bin/bash

HTTP_PORT=${HTTP_PORT:-8080}
H2C_PORT=${H2C_PORT:-8081}
H2_PORT=${H2_PORT:-8082}
cat <<EOF > /etc/httpd/conf.d/virtual-hosts.conf
Listen $HTTP_PORT
Listen $H2C_PORT
Listen $H2_PORT

ServerName localhost  

<VirtualHost *:$HTTP_PORT>
DocumentRoot /var/www/html1
ServerName www.h.example.org
Protocols http/1.1
</VirtualHost>

<VirtualHost *:$H2C_PORT>
DocumentRoot /var/www/html2
ServerName www.h2c.example.org
Protocols h2c
</VirtualHost>

<VirtualHost *:$H2_PORT>
DocumentRoot /var/www/html3
ServerName www.h2.example.org
Protocols h2
SSLEngine on
SSLCertificateFile "cert"
SSLCertificateKeyFile "key"
SSLCipherSuite HIGH:!aNULL:!MD5
</VirtualHost>
EOF

/usr/sbin/httpd -DFOREGROUND

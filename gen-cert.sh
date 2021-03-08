#!/bin/bash

mkdir certs
cat <<'EOF' > certs/config
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no
[req_distinguished_name]
C = CA
ST = Arctica
L = Northpole
O = Accme Inc
OU = DevOps
CN = www.company.org
[v3_req]
keyUsage = critical, digitalSignature, keyAgreement
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = www.h2.example.org
EOF

openssl req -x509 -new -nodes -keyout certs/key -sha256 -days 10240 -out certs/cert -config certs/config

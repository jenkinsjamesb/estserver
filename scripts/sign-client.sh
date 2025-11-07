#!/bin/bash
rm -rf server
mkdir -p server/

openssl genrsa -aes256 \
      -out server/private.key.pem 2048
chmod 400 server/private.key.pem

openssl req -config int-openssl.cnf \
      -key server/private.key.pem \
      -new -sha256 -out server/csr.pem \
      -addext "subjectAltName = DNS:example.localdomain" 

openssl ca -config int-openssl.cnf \
      -extensions usr_cert -days 375 -notext -md sha256 \
      -in server/csr.pem \
      -out server/cert.pem -subj "/CN=example.foo.bar/C=US/ST=CA/O=CERTMANAGER" 

chmod 444 server/cert.pem
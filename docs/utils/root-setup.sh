#!/bin/bash
rm -rf root
mkdir -p root/ca
cd root/ca
mkdir cers crl newcerts private certs

chmod 700 private
touch index.txt
echo 1000 > serial

openssl genrsa -aes256 -out private/ca.key.pem 4096
chmod 400 private/ca.key.pem
cd ../..


openssl req -config root-openssl.cnf \
      -key root/ca/private/ca.key.pem \
      -new -x509 -days 7300 -sha256 -extensions v3_ca \
      -out root/ca/certs/ca.cert.pem -subj "/CN=bar.ca/C=US/ST=CA/O=CERTMANAGER"
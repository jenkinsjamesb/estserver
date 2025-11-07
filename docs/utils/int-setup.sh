#!/bin/bash
rm -rf int-ca
mkdir -p int-ca
cd int-ca
mkdir cers crl newcerts private certs csr

chmod 700 private
touch index.txt
echo 1000 > serial

echo 1000 > int-ca/crlnumber

openssl genrsa -aes256 -out private/intermediate.key.pem 4096
chmod 400 private/intermediate.key.pem
cd ../..


openssl req -config int-openssl.cnf -new -sha256 \
      -key int-ca/private/intermediate.key.pem \
      -out int-ca/csr/intermediate.csr.pem -subj "/CN=foo.bar.int/C=US/ST=CA/O=CERTMANAGER"


openssl ca -config root-openssl.cnf -extensions v3_intermediate_ca \
      -days 3650 -notext -md sha256 \
      -in int-ca/csr/intermediate.csr.pem \
      -out int-ca/certs/intermediate.cert.pem


chmod 444 int-ca/certs/intermediate.cert.pem
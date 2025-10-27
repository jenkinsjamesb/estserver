cd $2

openssl genrsa -aes256 -out private/$1.key.pem 2048

chmod 400 private/$1.key.pem

openssl req -config openssl.cnf \
    -key private/$1.key.pem \
    -new -sha256 -out csr/$1.csr.pem \
    -subj $3 \
    -addext $4

# Replace with usr_crt for client cert
openssl ca -config openssl.cnf -extensions server_cert \ 
    -days 375 -notext -md sha256 -in csr/$1.csr.pem \
    -out certs/$1.cert.pem

chmod 444 certs/$1.cert.pem


# Verify 
openssl x509 -noout -text -in certs/$1.cert.pem
openssl verify -CAfile certs/ca-chain.cert.pem \
    certs/$1.cert.pem
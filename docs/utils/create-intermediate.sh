rm -r $1/intermediate-ca
mkdir $1/intermediate-ca

cp intermediate.openssl.cnf $1/intermediate-ca/openssl.cnf
cp intermediate.passwd $1/intermediate-ca/passwd


cd $1/intermediate-ca

mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

echo 1000 > crlnumber

openssl genrsa -aes256 -out private/intermediate.key.pem -passout file:passwd 4096

chmod 400 private/intermediate.key.pem


openssl req -config openssl.cnf -new -sha256 \
    -key private/intermediate.key.pem -passin file:passwd \
    -subj $3 \
    -out csr/intermediate.csr.pem


openssl ca -config $2/openssl.cnf -extensions v3_intermediate_ca \
    -days 3650 -notext -md sha256 -in csr/intermediate.csr.pem \
    -out certs/intermediate.cert.pem

chmod 444 certs/intermediate.cert.pem


# Verify
openssl x509 -noout -text -in certs/intermediate.cert.pem

openssl verify -CAfile $2/certs/ca.cert.pem certs/intermediate.cert.pem

cat certs/intermediate.cert.pem $2/certs/ca.cert.pem > \
    certs/ca-chain.cert.pem

chmod 444 certs/ca-chain.cert.pem

# Our certificate chain file must include the root certificate because no client application knows about it yet. A better option, particularly if you’re administrating an intranet, is to install your root certificate on every client that needs to connect. In that case, the chain file need only contain your intermediate certificate.
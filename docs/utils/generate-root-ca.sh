# Choose a directory (/root/ca) to store all keys and certificates.
rm -r $1/root-ca
mkdir $1/root-ca

cp root.openssl.cnf $1/root-ca/openssl.cnf
cp root.passwd $1/root-ca/passwd

cd $1/root-ca

# Create the directory structure. The index.txt and serial files act as a flat file database to keep track of signed certificates.
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

# -passin file:/path/to/passwd for automation 
openssl genrsa -aes256 -out private/ca.key.pem -passout file:passwd 4096 

# Set Root CA key permissions
chmod 400 private/ca.key.pem

# Create the root CA certificate
# FIXME: add info in command (merge with old gen certs script)
openssl req -config openssl.cnf -key private/ca.key.pem -passin file:passwd -new -x509 \
        -subj $2 \
        -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem

# Set Root CA cert permissions
chmod 444 certs/ca.cert.pem

# Verify:
openssl x509 -noout -text -in certs/ca.cert.pem



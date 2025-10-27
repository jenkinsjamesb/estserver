# dest dir, subj line
sh generate-root-ca.sh . "/C=US/ST=Virginia/L=Richmond/O=--/OU=--/CN=example/"

# dest dir, root ca dir, subj line
sh create-intermediate.sh . ./root-ca "/C=US/ST=Virginia/L=Richmond/O=--/OU=--/CN=example/"

# server name, CA dir, subj line, ext line
sh create-server.sh estserver ./intermediate-ca "/C=US/ST=Virginia/L=Richmond/O=--/OU=--/CN=example/", "subjectAltName = DNS:example.localdomain" 
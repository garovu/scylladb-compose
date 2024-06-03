# Please read below link for more information
# https://opensource.docs.scylladb.com/stable/operating-scylla/security/generate-certificate.html

# Generate a self-signing certificate authority key

openssl genrsa -out ./certs/cadb.key 4096

# A certificate signing authority
# Change ./certs/db.cfg to your own configuration file
openssl req -x509 -new -nodes -key ./certs/cadb.key -days 3650 -config ./certs/db.cfg -out ./certs/cadb.pem

# Generate a private key for our certificate

openssl genrsa -out ./certs/db.key 4096

# Create signing request

openssl req -new -key ./certs/db.key -out ./certs/db.csr -config ./certs/db.cfg

# Then we can finally create and sign our certificate

openssl x509 -req -in ./certs/db.csr -CA ./certs/cadb.pem -CAkey ./certs/cadb.key -CAcreateserial  -out ./certs/db.crt -days 365 -sha256

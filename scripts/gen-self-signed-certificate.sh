# Please read below link for more information
# https://opensource.docs.scylladb.com/stable/operating-scylla/security/generate-certificate.html

# Generate a self-signing certificate authority key

openssl genrsa -out cadb.key 4096

# A certificate signing authority
# Change ./certs/db.cfg to your own configuration file
openssl req -x509 -new -nodes -key cadb.key -days 3650 -config /db.cfg -out cadb.pem

# Generate a private key for our certificate

openssl genrsa -out db.key 4096

# Create signing request

openssl req -new -key db.key -out db.csr -config db.cfg

# Then we can finally create and sign our certificate

openssl x509 -req -in db.csr -CA cadb.pem -CAkey cadb.key -CAcreateserial  -out db.crt -days 365 -sha256
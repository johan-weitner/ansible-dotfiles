#!/bin/bash

echo "Adding root cert to '$1'"

mkdir "/etc/containers/certs.d/$1/"
cp /etc/containers/certs.d/docker.io/SBABBankRootCertificateAuthority1.pem "/etc/containers/certs.d/$1/"

echo ""
echo "Done!"

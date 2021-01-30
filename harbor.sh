#!/usr/bin/env bash
set -euxo pipefail
tdnf update -y
tdnf install -y ca-certificates
tdnf install -y openssl-c_rehash
TRUSTED_CERT="-----BEGIN CERTIFICATE-----
MIIF4zCCA8ugAwIBAgIUFGm1lRN8maxz6oPzk+iiCHLKBAowDQYJKoZIhvcNAQEN
BQAwbDELMAkGA1UEBhMCS1IxDjAMBgNVBAgMBVNlb3VsMQ4wDAYDVQQHDAVTZW91
bDEQMA4GA1UECgwHZXhhbXBsZTERMA8GA1UECwwIUGVyc29uYWwxGDAWBgNVBAMM
DzE5Mi4xNjguMTUwLjE0MzAeFw0yMTAxMjgwOTA1MzRaFw0zMTAxMjYwOTA1MzRa
MGwxCzAJBgNVBAYTAktSMQ4wDAYDVQQIDAVTZW91bDEOMAwGA1UEBwwFU2VvdWwx
EDAOBgNVBAoMB2V4YW1wbGUxETAPBgNVBAsMCFBlcnNvbmFsMRgwFgYDVQQDDA8x
OTIuMTY4LjE1MC4xNDMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDy
ExpXiYuwCXBvNLzl5CFVPf5lyRDp0rP7eneCouyIHZlfiv0wjsN1EKrIwoRX6i7V
tDmqnZdsIATCMKV+VKZvq/qdWYSVoLFaH2vRXIZ0EhIRtOjDYlYWDYcXfNzzpvR+
y7zVdBTsVRfqbHbat3XT1J46jUkxoJdntA/BFuF7AHVGVC4THbXkiPWtQeOwrbPj
LnbjX7hiT13lwgXanS3tYx0XRqvlo2KI5TpznbcE404VCoBzc/oknRkZRWQ0vPhG
eYurFmv3CB3kKIxgXYh7IocDe+m0xNFvBbQP1zU/Mimcsmj7rep3f+9iFlNJTlyv
YTFuQHaxBU5FbmWyLusaRJcepT89D97hRUSPQriFrMvYBvV5t8Vtz1zBDvQOM4we
sDFH93pUrk99zoh8UMiDk3WZSBW5cq4C/G/r9/FuIaUxq1NEKxx//fl6jABEFyRJ
aIMhxyEPvVRJ9kdL2ws+ZzGM0PcLJSCq9fSeXtzlKKrnNpdQOU1jAMgiB9MfA0Xf
EbQLlWNNqsU++9w60M1jiiIIOP5K2Q1XNzcVr233JlWQlOau5ZbPRVOz5mv4uth+
6PAek5VN5zhh1tKk3nyeEMheYfPeThlxAU96ZMB2/nw0FxrZ+ZjuN5Aqqafu3V15
Az2xSGuHRGu29bf0/WhMJ14wMOpX1ewoo4CjeS65DwIDAQABo30wezAfBgNVHSME
GDAWgBRh9adTQGMU4cokdh5kn4iu4GoBtzAJBgNVHRMEAjAAMAsGA1UdDwQEAwIE
8DATBgNVHSUEDDAKBggrBgEFBQcDATArBgNVHREEJDAighpoYXJib3IubmgudGFu
enUuZGVtby5sb2NhbIcEwKiWjzANBgkqhkiG9w0BAQ0FAAOCAgEAxoodn5psGGAA
PjzEk/Tv80zN5UDybE6ZkUsVc/ift1yXZmY8xSZnT1UVm9D1hcuHk46yO0WACgdn
5fadi73MbX3NvUZ7EHKtM1aSX2kTgp8ZZp3+Xf26xwntW8SSLR5uFDGrJW6JVhRW
i7HWdxpNl5PGgWTk3+3AMvjqJe+ISDKz1JiAYn0jV9MrKhd9Fx6nxeqflDsF703D
HJRAPOg0emwksBQZWIIz+euHTFan+4P90rODsArApQ1MZfP4Mgjt8+d91foLnVkB
Lb6D5F6Y+R+XxiL9UGKhaNuGd8/CC1qj/MmxGkDYH9pDzxNfJkd2poIRgGUDa22B
XvcOJi+lqokBkRfMEc5W/tCyrc4lduXH8INNjtN0cjIbJhoPlziRgtnM9uQf5n/G
yB1AhquCWpI6MYC2a02r5uUkYDKG0uLfn9m5DY8OyoVPf6V9J2xAOiB+gbWOjHzb
iCaDklrraUJFX7KMMw232x6cPVRQFpKosgaPU27DqL9yUkbjVA8y6LcFyRjJ7D4N
RCE6swQkL58ExTVzFofqJQ7cQ+B5L/h7wSO27ys7r8knZVC5Hu0MKZ5togxPzlHM
9T6m70WdR8YJP66OysM+CUwuSNujR/2GA9SzAejd8hqJ2ADxiMoPoDbSc4uaRPgA
7BRh8glwkfv5PV8WQ2b6MxG9ZDXKxlM=
-----END CERTIFICATE-----
"
echo "$TRUSTED_CERT" > /etc/ssl/certs/harbor.crt
/usr/bin/rehash_ca_certificates.sh
echo "Finished, restarting containerd"
systemctl restart containerd
echo "done"
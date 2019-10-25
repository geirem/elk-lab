## ca/
* ca_cert.pem is the internal VLAN cert.  It should be regenerated if new certs should
  be issued from it.  And its issued certs should only be used on the host-local VLAN; if it is
  needed on LAN, new certs should be issued from the proper CA.
* stb_ca_cert.pem is the common STB CA cert.

## lumberjack/
This certificate is meant only for local VLAN, and must never be used between
hosts!

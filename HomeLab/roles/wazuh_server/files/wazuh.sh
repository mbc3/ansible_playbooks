#!/usr/bin/bash
# Copy fullchain.pem and pivkey.pem to wazuh for tls
HOSTNAME=$(hostname | cut -f 1 -d ".")
DOMAIN="localdomain"
CERT_DIR="/etc/letsencrypt/live/$HOSTNAME.$DOMAIN"
WAZUH_CERT_DIR="/etc/wazuh-dashboard/certs"
CERTS=("fullchain.pem" "privkey.pem")

for cert in "${CERTS[@]}"; do
  cp "$CERT_DIR/$cert" "$WAZUH_CERT_DIR/$cert"
  chown wazuh-dashboard:wazuh-dashboard "$WAZUH_CERT_DIR/$cert"
  chmod 0400 "$WAZUH_CERT_DIR/$cert"
done
/bin/systemctl restart wazuh-dashboard

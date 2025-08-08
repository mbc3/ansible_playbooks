#!/usr/bin/bash
# Creates a pem file with the fullchain and key, as pihole annoyingly wants
CERT="homelab_pihole_full.pem"
HOSTNAME=$(hostname | cut -f 1 -d ".")
DOMAIN="localdomain"
CERT_DIR="/etc/letsencrypt/live/$HOSTNAME.$DOMAIN"
PIHOLE_CERT_DIR="/etc/pihole"

# delete old pihole cert
if [[ -f "$PIHOLE_CERT_DIR/$CERT" ]]; then
  rm "$PIHOLE_CERT_DIR/$CERT"
fi
if [[ -f "$CERT_DIR/$CERT" ]]; then
  rm "$CERT_DIR/$CERT"
fi
# create the full chain cert
cat "$CERT_DIR/privkey.pem" "$CERT_DIR/fullchain.pem" >"$CERT_DIR/$CERT"
cp "$CERT_DIR/$CERT" "$PIHOLE_CERT_DIR/$CERT"
chown pihole:pihole "$PIHOLE_CERT_DIR/$CERT"
chmod 0660 "$PIHOLE_CERT_DIR/$CERT"

#restart pihole service
systemctl restart pihole-FTL.service

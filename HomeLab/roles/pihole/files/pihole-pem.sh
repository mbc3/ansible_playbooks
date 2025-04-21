#!/usr/bin/bash
# Creates a pem file with the fullchain and key, as pihole annoyingly wants
CERTS=("homelab_pihole_full.pem")
CERT_DIR="/etc/letsencrypt/live/$(hostname)"
PIHOLE_CERT_DIR="/etc/pihole"
cat "$(readlink -f "$CERT_DIR"/privkey.pem)" "$(readlink -f "$CERT_DIR"/fullchain.pem)" >"$CERT_DIR"/homelab_pihole_full.pem
for cert in "${CERTS[@]}"; do
    if [[ -f $PIHOLE_CERT_DIR/$cert ]]; then
        echo "hardlink $PIHOLE_CERT_DIR/$cert exists, skipping"
    else
        ln "$CERT_DIR"/"$cert" "$PIHOLE_CERT_DIR"/"$cert"
        chown pihole:pihole "$PIHOLE_CERT_DIR/$cert"
        chmod 0600 "$PIHOLE_CERT_DIR/$cert"
    fi
done

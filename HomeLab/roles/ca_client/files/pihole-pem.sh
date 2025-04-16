#!/usr/bin/bash
# Creates a pem file with the fullchain and key, as pihole annoyingly wants
HOST=$(hostname).localdomain
DIR=/etc/letsencrypt/live/
KEY=$(readlink "$DIR""$HOST"/privkey.pem)
CERT=$(readlink "$DIR""$HOST"/cert.pem)
cat "$KEY" "$CERT" >"$DIR""$HOST"/pihole.pem
chown pihole:pihole "$DIR""$HOST"/pihole.pem
chmod 0600 "$DIR""$HOST"/pihole.pem
mv "$DIR""$HOST"/pihole.pem /etc/pihole

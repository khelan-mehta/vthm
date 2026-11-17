#!/usr/bin/env bash
# Re-encrypt ./dashboard into dashboard.tar.gz.enc. Usage: ./encrypt.sh [keyfile]
set -euo pipefail
cd "$(dirname "$0")"
KEY="${1:-dashboard.key}"
[ -f "$KEY" ] || { echo "Key file '$KEY' not found."; exit 1; }
[ -f dashboard/package.json ] || { echo "Nothing to encrypt: ./dashboard not found."; exit 1; }
tar --exclude=node_modules --exclude=dist -czf - dashboard \
  | openssl enc -aes-256-cbc -pbkdf2 -iter 600000 -salt -pass "file:$KEY" -out dashboard.tar.gz.enc.tmp
mv dashboard.tar.gz.enc.tmp dashboard.tar.gz.enc
echo "Encrypted. Commit dashboard.tar.gz.enc."

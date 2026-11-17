#!/usr/bin/env bash
# Decrypt dashboard.tar.gz.enc into ./dashboard. Usage: ./decrypt.sh [keyfile]
set -euo pipefail
cd "$(dirname "$0")"
KEY="${1:-dashboard.key}"
[ -f "$KEY" ] || { echo "Key file '$KEY' not found. See README.md."; exit 1; }
openssl enc -d -aes-256-cbc -pbkdf2 -iter 600000 -pass "file:$KEY" -in dashboard.tar.gz.enc | tar -xzf -
echo "Decrypted into ./dashboard. See dashboard/SETUP.md."

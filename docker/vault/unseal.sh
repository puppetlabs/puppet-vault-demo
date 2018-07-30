#!/bin/sh
set -e

echo "Initialize Vault"
vault operator init -key-shares=1 -key-threshold=1 | tee vault.keys
VAULT_TOKEN=$(grep '^Initial' vault.keys | awk '{print $4}')
VAULT_KEY=$(grep '^Unseal Key 1:' vault.keys | awk '{print $4}')

export VAULT_TOKEN

vault operator unseal "$VAULT_KEY"

echo "Create secret_reader policy that can read from secret/*"

vault policy write secret_reader - <<EOF
path "secret/*" {
    capabilities = ["read"]
}
EOF

echo "Enable cert auth and add puppet server CA for secret_reader"
echo "Adding cert auth paths."

vault auth enable cert

vault write auth/cert/certs/vault.docker display_name='puppet cert' certificate=@/vault/config/ca.pem policies=secret_reader

echo 'Write secret/test: foo=bar'

vault write secret/test foo=bar

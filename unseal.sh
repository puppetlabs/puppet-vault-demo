#!/bin/bash
# docker exec -i puppet-vault-demo_vault_1 /bin/sh < unseal.sh
set -e

echo "VAULT_ADDR is $VAULT_ADDR"
echo "Initialize Vault"
vault operator init -key-shares=1 -key-threshold=1 > vault.keys
export VAULT_TOKEN=$(cat vault.keys | grep '^Initial' | awk '{print $4}')
echo “vault token is: $VAULT_TOKEN”

vault operator unseal `cat vault.keys | grep '^Unseal Key 1:' | awk '{print $4}'`

echo “Vault unseal complete.”

echo "Adding cert auth paths."

vault auth enable cert

echo "Modify the default policy to be able to read from secret/*"

hcl_policy() {
    cat <<EOF
path "secret/*" {
    capabilities = ["read"]
}
EOF
}

hcl_policy > policy.hcl

vault policy write secret_reader policy.hcl

echo 'secret_reader policy created'

vault write auth/cert/certs/vault.docker display_name='puppet cert' certificate=@/vault/config/ca.pem policies=secret_reader

echo "cert auth enabled for all certs signed by puppetserver CA with secret_reader policy"

vault write secret/test foo=bar

echo 'single secret written out, secret/test foo=bar'

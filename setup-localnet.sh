#!/usr/bin/env bash
# This script configures the devnet for test transfers with hardcoded addresses.
set -x

solana-test-validator &

sleep 5

mkdir -p ~/.config/solana/cli
cat <<EOF > ~/.config/solana/cli/config.yml
json_rpc_url: "http://127.0.0.1:8899"
websocket_url: ""
keypair_path: /owner.json
EOF


retry () {
  while ! "$@"; do
    sleep 1
  done
}

# Fund our account (as defined in solana/keys/solana-devnet.json).
retry solana airdrop 10

# Create a new SPL token
token=$(spl-token create-token ./mint.json --decimals 5 --fee-payer ./owner.json --mint-authority ./owner.json  | grep 'Creating token' | awk '{ print $3 }')
echo "Created token $token"

# Create token owner account
account=$(spl-token create-account "$token" | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account $account"

# Mint new tokens owned by our CLI account
spl-token mint "$token" 10000000000000 "$account"

# Create token alice account
account1=$(spl-token create-account "$token" --owner ./alice.json --fee-payer ./owner.json | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account $account1"

# Airdrop alice tokens
transfer=$(spl-token transfer "$token" 100000 "$account1" --fee-payer ./owner.json --owner ./owner.json)
echo "Airdrop 100000 to Alice $transfer"

# Create token alice account
account2=$(spl-token create-account "$token" --owner ./bob.json --fee-payer ./owner.json | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account $account2"

sleep infinity

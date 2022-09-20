#!/usr/bin/env bash
set -x
set -m

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
token_mog=$(spl-token create-token ./mint-mog.json --decimals 5 --fee-payer ./owner.json --mint-authority ./owner.json  | grep 'Creating token' | awk '{ print $3 }')
echo "Created token $token_mog"

# Create a new SPL token
token_usd=$(spl-token create-token ./mint-usd.json --decimals 2 --fee-payer ./owner.json --mint-authority ./owner.json  | grep 'Creating token' | awk '{ print $3 }')
echo "Created token $token_usd"

# Create a new SPL token
token_eur=$(spl-token create-token ./mint-eur.json --decimals 2 --fee-payer ./owner.json --mint-authority ./owner.json  | grep 'Creating token' | awk '{ print $3 }')
echo "Created token $token_eur"


# Create token owner account
account_mog=$(spl-token create-account "$token_mog" | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account $account_mog"

# Create token owner account
account_usd=$(spl-token create-account "$token_usd" | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account $account_usd"

# Create token owner account
account_eur=$(spl-token create-account "$token_eur" | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account $account_eur"


# Mint new tokens owned by our CLI account
spl-token mint "$token_mog" 10000000000000 "$account_mog"

# Mint new tokens owned by our CLI account
spl-token mint "$token_usd" 1000000000000000 "$account_usd"

# Mint new tokens owned by our CLI account
spl-token mint "$token_eur" 10000000000000000 "$account_eur"



# Create alice token account
account_mog_alice=$(spl-token create-account "$token_mog" --owner ./alice.json --fee-payer ./owner.json | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account alice $account_mog_alice"

# Create alice token account
account_usd_alice=$(spl-token create-account "$token_usd" --owner ./alice.json --fee-payer ./owner.json | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account alice $account_usd_alice"

# Create alice token account
account_eur_alice=$(spl-token create-account "$token_eur" --owner ./alice.json --fee-payer ./owner.json | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account alice $account_eur_alice"


# Airdrop alice tokens
transfer_mog_alice=$(spl-token transfer "$token_mog" 100000 "$account_mog_alice" --fee-payer ./owner.json --owner ./owner.json)
echo "Airdrop 100000 to Alice $transfer_mog_alice"

# Airdrop alice tokens
transfer_usd_alice=$(spl-token transfer "$token_usd" 100000 "$account_usd_alice" --fee-payer ./owner.json --owner ./owner.json)
echo "Airdrop 100000 to Alice $transfer_usd_alice"

# Airdrop alice tokens
transfer_eur_alice=$(spl-token transfer "$token_eur" 100000 "$account_eur_alice" --fee-payer ./owner.json --owner ./owner.json)
echo "Airdrop 100000 to Alice $transfer_eur_alice"


# Create bob token account
account_mog_bob=$(spl-token create-account "$token_mog" --owner ./bob.json --fee-payer ./owner.json | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account bob $account_mog_bob"

# Create charlie token account
account_mog_charlie=$(spl-token create-account "$token_mog" --owner ./charlie.json --fee-payer ./owner.json | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account charlie $account_mog_charlie"

# Create dave token account
account_mog_dave=$(spl-token create-account "$token_mog" --owner ./dave.json --fee-payer ./owner.json | grep 'Creating account' | awk '{ print $3 }')
echo "Created token account dave $account_mog_dave"

fg

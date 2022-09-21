#!/usr/bin/env bash
set -m
export SOURCE="${PWD}/accounts"
export URL="http://localhost:8899"

# Get all the filenames of the files in the 'accounts' directory
ACCOUNTS=()
for FILE in "$SOURCE"/*
do
  FILENAME=$(basename "$FILE")
  ACCOUNTS+=("${FILENAME%.*}")
done

# Create the parameters for the solana-test-validator command
PARAMS=""
for ACCOUNT in "${ACCOUNTS[@]}"
do
  PARAMS+="--account $ACCOUNT ${SOURCE}/${ACCOUNT}.json "
done

# Remove any existing ledger data
rm -rf test-ledger

# Start the solana-test-validator and put it in the background
solana-test-validator $PARAMS &

# Wait a bit for the validator to start
sleep 3

# Configure the Solana CLI to use the test validator
mkdir -p ~/.config/solana/cli
cat <<EOF > ~/.config/solana/cli/config.yml
json_rpc_url: "http://127.0.0.1:8899"
websocket_url: ""
keypair_path: /keys/owner.json
EOF

# Airdrop some SOL to the fee payer account
solana airdrop 10 --url $URL oWNEYV3aMze3CppdgyFAiEj9xUJXkn85es1KscRHt8m

# Bring the solar-test-validator process to the foreground
fg

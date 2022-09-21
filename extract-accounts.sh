#!/usr/bin/env bash

export SOURCE="${PWD}/accounts"
export URL="http://localhost:8899"

# Get all the filenames of the files in the 'accounts' directory
ACCOUNTS=()
for FILE in "$SOURCE"/*
do
  FILENAME=$(basename "$FILE")
  ACCOUNTS+=("${FILENAME%.*}")
done

# Loop through the accounts and extract them from the running validator
for ACCOUNT in "${ACCOUNTS[@]}"
do
  TARGET="$SOURCE/$ACCOUNT.json"
  CREATED=$(solana account -u "$URL" "$ACCOUNT" --output json -o "$TARGET")
  echo "Created account $CREATED"
done

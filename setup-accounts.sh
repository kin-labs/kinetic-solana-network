#!/usr/bin/env bash
# This script configures the devnet for test transfers with hardcoded addresses.
#set -x
#set -m

export KEYS="${PWD}/keys"
export URL="http://localhost:8899"
export OWNER="${KEYS}/owner.json"
export MINT_MOG="${KEYS}/mint-mog.json"
export MINT_USD="${KEYS}/mint-usd.json"
export MINT_EUR="${KEYS}/mint-eur.json"
export ALICE="${KEYS}/alice.json"
export BOB="${KEYS}/bob.json"
export CHARLIE="${KEYS}/charlie.json"
export DAVE="${KEYS}/dave.json"

sol_airdrop=$(solana airdrop 10 -u "$URL" "oWNEYV3aMze3CppdgyFAiEj9xUJXkn85es1KscRHt8m")
echo "SOL Airdrop $sol_airdrop"

############################
echo "CREATING SPL TOKENS" #
############################
token_mog=$(spl-token create-token -u "$URL" "$MINT_MOG" --decimals 5 --fee-payer "$OWNER" --mint-authority "$OWNER"  | grep 'Creating token' | awk '{ print $3 }')
echo " -> Created token $token_mog"
token_usd=$(spl-token create-token -u "$URL" "$MINT_USD" --decimals 2 --fee-payer "$OWNER" --mint-authority "$OWNER"  | grep 'Creating token' | awk '{ print $3 }')
echo " -> Created token $token_usd"
token_eur=$(spl-token create-token -u "$URL" "$MINT_EUR" --decimals 2 --fee-payer "$OWNER" --mint-authority "$OWNER"  | grep 'Creating token' | awk '{ print $3 }')
echo " -> Created token $token_eur"

####################################
echo "CREATING SPL TOKEN ACCOUNTS" #
####################################
account_mog=$(spl-token create-account -u "$URL" "$token_mog" --fee-payer "$OWNER" --owner "$OWNER" | grep 'Creating account' | awk '{ print $3 }')
echo " -> Created token account $account_mog"
account_usd=$(spl-token create-account -u "$URL" "$token_usd" --fee-payer "$OWNER" --owner "$OWNER" | grep 'Creating account' | awk '{ print $3 }')
echo " -> Created token account $account_usd"
account_eur=$(spl-token create-account -u "$URL" "$token_eur" --fee-payer "$OWNER" --owner "$OWNER" | grep 'Creating account' | awk '{ print $3 }')
echo " -> Created token account $account_eur"

####################
echo "MINT TOKENS" #
####################
mint_sig_mog=$(spl-token mint -u "$URL" --fee-payer "$OWNER" --owner "$OWNER" "$token_mog" 10000000000000 "$account_mog" | grep 'Signature' | awk '{ print $2 }')
echo " -> Mint tokens $token_mog => $account_mog : $mint_sig_mog"
mint_sig_usd=$(spl-token mint -u "$URL" --fee-payer "$OWNER" --owner "$OWNER" "$token_usd" 1000000000000000 "$account_usd" | grep 'Signature' | awk '{ print $2 }')
echo " -> Mint tokens $token_usd => $account_usd : $mint_sig_usd"
mint_sig_eur=$(spl-token mint -u "$URL" --fee-payer "$OWNER" --owner "$OWNER" "$token_eur" 10000000000000000 "$account_eur" | grep 'Signature' | awk '{ print $2 }')
echo " -> Mint tokens $token_eur => $account_eur : $mint_sig_eur"

####################################
echo "CREATE TOKEN ACCOUNTS ALICE" #
####################################
account_mog_alice=$(spl-token create-account -u "$URL" "$token_mog" --owner "$ALICE" --fee-payer "$OWNER" | grep 'Creating account' | awk '{ print $3 }')
echo " -> Created token account ALICE $account_mog_alice"
account_usd_alice=$(spl-token create-account -u "$URL" "$token_usd" --owner "$ALICE" --fee-payer "$OWNER" | grep 'Creating account' | awk '{ print $3 }')
echo " -> Created token account ALICE $account_usd_alice"
account_eur_alice=$(spl-token create-account -u "$URL" "$token_eur" --owner "$ALICE" --fee-payer "$OWNER" | grep 'Creating account' | awk '{ print $3 }')
echo " -> Created token account ALICE $account_eur_alice"

#############################
echo "AIRDROP TOKENS ALICE" #
#############################
airdrop_sig_mog_alice=$(spl-token transfer -u "$URL" "$token_mog" 100000 "$account_mog_alice" --fee-payer "$OWNER" --owner "$OWNER" | grep 'Signature' | awk '{ print $2 }')
echo " -> Airdrop to Alice: $token_mog 100000 $airdrop_sig_mog_alice"
airdrop_sig_usd_alice=$(spl-token transfer -u "$URL" "$token_usd" 100000 "$account_usd_alice" --fee-payer "$OWNER" --owner "$OWNER" | grep 'Signature' | awk '{ print $2 }')
echo " -> Airdrop to Alice: $token_usd 100000 $airdrop_sig_usd_alice"
airdrop_sig_eur_alice=$(spl-token transfer -u "$URL" "$token_eur" 100000 "$account_eur_alice" --fee-payer "$OWNER" --owner "$OWNER" | grep 'Signature' | awk '{ print $2 }')
echo " -> Airdrop to Alice: $token_eur 100000 $airdrop_sig_eur_alice"

###########################
echo "AIRDROP TOKENS BOB" #
###########################
account_mog_bob=$(spl-token create-account -u "$URL" "$token_mog" --owner "$BOB" --fee-payer "$OWNER" | grep 'Creating account' | awk '{ print $3 }')
echo " -> Created token account BOB $account_mog_bob"

###############################
echo "AIRDROP TOKENS CHARLIE" #
###############################
account_mog_charlie=$(spl-token create-account -u "$URL" "$token_mog" --owner "$CHARLIE" --fee-payer "$OWNER" | grep 'Creating account' | awk '{ print $3 }')
echo " -> Created token account CHARLIE $account_mog_charlie"

############################
echo "AIRDROP TOKENS DAVE" #
############################
account_mog_dave=$(spl-token create-account -u "$URL" "$token_mog" --owner "$DAVE" --fee-payer "$OWNER" | grep 'Creating account' | awk '{ print $3 }')
echo " -> Created token account DAVE $account_mog_dave"

#!/usr/bin/env bash

export ACCOUNTS="${PWD}/accounts"
export URL="http://localhost:8899"

export OWNER=oWNEYV3aMze3CppdgyFAiEj9xUJXkn85es1KscRHt8m
export MINT_MOG=MoGaMuJnB3k8zXjBYBnHxHG47vWcW3nyb7bFYvdVzek
export MINT_USD=USDzo281m7rjzeZyxevkzL1vr5Cibb9ek3ynyAjXjUM
export MINT_EUR=EURuPGeii6cp54mSpicU3ChPGanijr8QU3FqVbLq5PN5
export MINT_MOG_TA_OWNER=5H5iLXerWrNcGFAmaR8DZJhH8uxyZ5AkFAQvx8wxbadz
export MINT_USD_TA_OWNER=98CQJv1mapenrtTYnyaWyY6MTv2TmbPQ4YSJKXNAGTnH
export MINT_EUR_TA_OWNER=G91BgP7v65WH6wi35mhdUuUgr9YaStyk4SCVxdtr8oxj
export MINT_MOG_TA_ALICE=Ebq6K7xVh6PYQ8DrTQnD9fC91uQiyBMPGSV6JCG6GPdD
export MINT_USD_TA_ALICE=JBdTmhBdwP5Hs4cYg123mn849FmVEHb1u1KGx998hMN7
export MINT_EUR_TA_ALICE=D9gAQViG8qtBngfoxuzGsU8LFASLx1fodGbv6SrUy1Dj
export MINT_MOG_TA_BOB=92gcR7aBdZDGvoC1cCSTSzQDediBZecy32B43mJtuUXT
export MINT_MOG_TA_CHARLIE=C6T7tHx5u3kKLVHHghC155rGk79cXjRQy11KtRsikS2k
export MINT_MOG_TA_DAVE=84PStBHQtpaxs3wsGGytjGc4iqZpWLVsfmWZEwtwkN8g

function export_account() {
    ACCOUNT="$1"
    TARGET="$ACCOUNTS/$ACCOUNT.json"
    created_res=$(solana account -u "$URL" "$ACCOUNT" --output json -o "$TARGET")
    echo "Created account $created_res"
}

export_account "$OWNER"
export_account "$MINT_MOG"
export_account "$MINT_USD"
export_account "$MINT_EUR"
export_account "$MINT_MOG_TA_OWNER"
export_account "$MINT_USD_TA_OWNER"
export_account "$MINT_EUR_TA_OWNER"
export_account "$MINT_MOG_TA_ALICE"
export_account "$MINT_USD_TA_ALICE"
export_account "$MINT_EUR_TA_ALICE"
export_account "$MINT_MOG_TA_BOB"
export_account "$MINT_MOG_TA_CHARLIE"
export_account "$MINT_MOG_TA_DAVE"

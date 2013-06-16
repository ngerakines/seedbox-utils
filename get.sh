#!/bin/sh

BUCKET=$1
PREFIX=$2

s3cmd ls s3://$BUCKET/$PREFIX/

s3cmd get s3://$BUCKET/$PREFIX/*

echo "Decrypting parts"
gpg --decrypt --multifile *.gpg

echo "Joining $FILE"

# Why be fancy?
FILE=$(cat MANIFEST)
FILE=${FILE#* }
FILE=$(basename $FILE)

echo $FILE
cat file-?? > "$FILE"

echo "Done. Match?"
cat MANIFEST
shasum $FILE

#!/bin/sh

set -e

SIZE=134217728

FILE=$3
TO=$1
BUCKET=$2

if [ ! -f "$FILE" ]; then
        echo "not a file"
        exit 1
fi

SUM=$(shasum "$FILE")

cat > MANIFEST << EOF
$SUM
EOF

echo $SUM

PREFIX=$(date +%s)

echo "Splitting $FILE"
split --bytes=134217728 "$FILE" x

ls x*

echo "Encrypting MANIFEST"
gpg --encrypt --recipient $TO MANIFEST

for i in x*
do
        echo "Encrypting $i"
        gpg --encrypt --recipient $TO $i
done

for i in *.gpg
do
        echo "Uploading part $i"
        s3cmd put $i s3://$BUCKET/$PREFIX/
done

echo "Done, cleaning up"
rm -rfv *


#!/bin/sh

BUCKET=$1

LS=$(s3cmd ls s3://$BUCKET | awk '{print $2}')

for i in $LS
do
	PREFIX=${i%?}
	PREFIX=${PREFIX##*/}
	echo "'$i' '$PREFIX'"
	s3cmd get ${i}MANIFEST.gpg $PREFIX-MANIFEST.gpg
done

gpg --decrypt --multifile *-MANIFEST.gpg

for i in *-MANIFEST
do
	echo $i
	cat $i
	rm $i $i.gpg
done

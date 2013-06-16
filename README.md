# seedbox-utils

These scripts assume a few things:

* On the "get" side, you created a gpg key.
* On the "put" side, you created a gpg key, imported the public key from the "get" side and gave it trust.
* On both "get" and "put" sides you've configured s3cmd.

# put.sh

A small script to split a file, encrypt the parts (using gpg) and put them onto s3.

    $ alias put='put.sh user@domain.com bucketabcdefg'
    $ TMP=`date +%s`; mkdir ~/tmp-$TMP; cd ~/tmp-$TMP
    $ put ~/files/awesome.data
    $ cd ~/
    $ rm -rfv ~/tmp-*

# get.sh

A script that fetches encrypted parts, decrypts them and pieces them back together.

    $ alias get='get.sh bucketabcdefg'
    $ TMP=`date +%s`; mkdir ~/tmp-$TMP; cd ~/tmp-$TMP
    $ get prefixa
    ...
    [gpg password]

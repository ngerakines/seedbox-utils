# seedbox-utils

# put.sh

A small script to split a file, encrypt the parts (using gpg) and put them onto s3.

    $ alias put='put.sh user@domain.com bucketabcdefg'
    $ TMP=`date +%s`; mkdir ~/tmp-$TMP; cd ~/tmp-$TMP
    $ put ~/files/awesome.data
    $ cd ~/
    $ rm -rfv ~/tmp-*


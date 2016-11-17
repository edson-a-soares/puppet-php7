#!/bin/sh

filename=$1

EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', '$filename');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm $filename
    exit 1
fi

exit 0

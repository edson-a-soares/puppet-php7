#!/bin/sh

path=$1
filename=$2

EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig --directory-prefix=$path)
ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', '$path/$filename');")

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm $path/$filename
    exit 1
fi

exit 0

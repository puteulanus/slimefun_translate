#!/bin/bash

cd /tmp/build-script

while read line
do
	echo $line | awk -F '[: ]' '{i=2; while (i<=NF) {system("./build.sh "$1" "$i"");i++}}'
done < list.txt

chmod -R +w /usr/www/
chown -R www:www /usr/www/
chmod -R a+w /usr/www/default/public_html

supervisord -nc /etc/supervisord.conf
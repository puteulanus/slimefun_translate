#!/bin/bash

plugin_name=$1
dic_name=$2

mkdir -p /usr/www/default/public_html/${plugin_name}
while read line
do
	rm -f tmp new.jar
	version=$(echo ${line} | awk -F ' ' '{print $1}')
	file_url=$(echo ${line} | awk -F ' ' '{print $2}')
	wget -O org.jar ${file_url}
	java -Xmx100M -jar pf.jar do -d ${plugin_name}/${dic_name} org.jar
	rm -rf org.jar
	mv new.jar /usr/www/default/public_html/${plugin_name}/${plugin_name}_${version}_${dic_name}.jar
done < ${plugin_name}/version.txt
FROM quay.io/puteulanus/lnmp:centos6

RUN rm -f /etc/supervisord.d/mysql.ini

ADD tools/pf.jar /tmp/pf.jar

RUN rpm -ivh 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=207764'
RUN yum install -y wget unzip
RUN wget 'http://dev.bukkit.org/media/files/920/245/Slimefun_v4.0.9.jar' -O /tmp/slimefun.jar

RUN wget 'https://release.larsjung.de/h5ai/h5ai-0.28.1.zip' -O /usr/www/default/public_html/h5ai.zip
RUN cd /usr/www/default/public_html/; unzip h5ai.zip
RUN rm -f /usr/www/default/public_html/h5ai.zip
RUN sed -i "s#index index.php;#index index.php /_h5ai/public/index.php;#g" /etc/nginx/conf.d/default.conf

ADD zh_CN /tmp/zh_CN
RUN cd /tmp/; java -jar pf.jar do -d zh_CN -o slimefun-zh_CN.jar slimefun.jar
RUN mv /tmp/slimefun-zh_CN.jar /usr/www/default/public_html/Slimefun-4.0.9-zh_CN.jar

RUN chmod -R +w /usr/www/
RUN chown -R www:www /usr/www/
RUN chmod -R a+w /usr/www/default/public_html

# Expose Ports
EXPOSE 80

# RUN
CMD ["supervisord", "-nc", "/etc/supervisord.conf"]
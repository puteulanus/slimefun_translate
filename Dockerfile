FROM quay.io/puteulanus/lnmp:centos6

RUN rm -f /etc/supervisord.d/mysql.ini

ADD tools/pf.jar /tmp/pf.jar

RUN yum install -y wget unzip
RUN rpm -ivh 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=207764'
RUN wget 'http://dev.bukkit.org/media/files/921/311/Slimefun_v4.0.10.jar' -O /tmp/slimefun.jar

ADD zh_CN /tmp/zh_CN
RUN cd /tmp/; java -jar pf.jar -d zh_CN -o slimefun-zh_CN.jar slimefun.jar
RUN mv /tmp/slimefun-zh_CN.jar /usr/www/default/public_html/

# Expose Ports
EXPOSE 80

# RUN
CMD ["supervisord", "-nc", "/etc/supervisord.conf"]
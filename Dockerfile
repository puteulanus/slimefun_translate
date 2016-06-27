FROM centos:centos6

ADD tools/pf.jar /tmp/pf.jar
ADD zh_CN /tmp/zh_CH

RUN yum install -y java-1.8.0-openjdk wget unzip
RUN wget 'http://dev.bukkit.org/media/files/921/311/Slimefun_v4.0.10.jar' -O /tmp/slimefun.jar
RUN cd /tmp/; java -jar pf.jar -d zh_CN -o slimefun-zh_CN.jar slimefun.jar
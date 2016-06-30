FROM quay.io/puteulanus/lnmp:centos6

# Disable mysql
RUN rm -f /etc/supervisord.d/mysql.ini

# Create build environment
ADD build-script /tmp/build-script
ADD dic /tmp/dic
RUN cp -r /tmp/dic/* /tmp/build-script/; rm -rf /tmp/dic

# Install requirements
RUN rpm -ivh 'http://javadl.oracle.com/webapps/download/AutoDL?BundleId=207764'
RUN yum install -y wget unzip

# Install h5ai
RUN wget 'https://release.larsjung.de/h5ai/h5ai-0.28.1.zip' -O /usr/www/default/public_html/h5ai.zip
RUN cd /usr/www/default/public_html/; unzip h5ai.zip
RUN rm -f /usr/www/default/public_html/h5ai.zip
RUN sed -i "s#index index.php;#index index.php /_h5ai/public/index.php;#g" /etc/nginx/conf.d/default.conf

# Fix permission
RUN chmod -R +w /usr/www/
RUN chown -R www:www /usr/www/
RUN chmod -R a+w /usr/www/default/public_html

# Expose Ports
EXPOSE 80

# Set Locale
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# RUN
#CMD ["supervisord", "-nc", "/etc/supervisord.conf"]
CMD /tmp/build-script/run.sh
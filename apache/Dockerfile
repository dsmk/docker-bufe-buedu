FROM amazonlinux:latest

ENV PATCHDATE 20170712
RUN yum -y update && yum clean all

RUN yum install -y httpd24 ruby && yum clean all

ADD run-httpd.sh /usr/sbin/run-httpd.sh

CMD /usr/sbin/run-httpd.sh

EXPOSE 80
EXPOSE 443

RUN mkdir /var/www/html/server 

ADD healthcheck /var/www/html/server/healthcheck

ADD httpd.conf /etc/httpd/conf/httpd.conf

COPY conf.modules.d/ /etc/httpd/conf.modules.d

COPY conf.d/ /etc/httpd/conf.d

#VOLUME /var/log/nginx
#VOLUME /etc/pki/nginx

#ADD get-cloudfront-ip.rb /usr/sbin/get-cloudfront-ip.rb
#ADD nginx.conf.erb /etc/nginx/nginx.conf.erb
#ADD conf.d-map-def.conf.erb /etc/nginx/conf.d/map-def.conf.erb
#ADD conf.d-ssl.conf.erb /etc/nginx/conf.d/ssl.conf.erb
#ADD conf.d-default.conf.erb /etc/nginx/conf.d/default.conf.erb
#ADD default.d-www.conf.erb /etc/nginx/default.d/www.conf.erb
#ADD sites.map /etc/nginx/sites.map


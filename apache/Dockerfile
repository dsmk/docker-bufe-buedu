FROM amazonlinux:latest

ENV PATCHDATE 20170712
RUN yum -y update && yum clean all

RUN yum install -y httpd24 mod24_ssl ruby && yum clean all

ADD files/run-httpd.sh /usr/sbin/run-httpd.sh

CMD /usr/sbin/run-httpd.sh

EXPOSE 80
EXPOSE 443

RUN mkdir /var/www/html/server \
  && chmod 755 /usr/sbin/run-httpd.sh \
  && rm /etc/httpd/conf.modules.d/00-dav.conf /etc/httpd/conf.modules.d/00-lua.conf \
  && rm /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/autoindex.conf

# the following two volumes are so we can do a handful of read-write things in controled situations
VOLUME /tmp
VOLUME /var/run/httpd

VOLUME /var/log/httpd
VOLUME /etc/pki/httpd

ADD files/healthcheck /var/www/html/server/healthcheck

ADD files/get-cloudfront-ip.rb /usr/sbin/get-cloudfront-ip.rb
ADD files/ip-ranges.json /etc/httpd/ip-ranges.json
ADD files/httpd.conf /etc/httpd/conf/httpd.conf

ADD files/sitemap.txt /etc/httpd/sitemap.txt

COPY files/conf.modules.d/ /etc/httpd/conf.modules.d

COPY files/conf.d/ /etc/httpd/conf.d

#VOLUME /var/log/nginx
#VOLUME /etc/pki/nginx

#ADD nginx.conf.erb /etc/nginx/nginx.conf.erb
#ADD conf.d-map-def.conf.erb /etc/nginx/conf.d/map-def.conf.erb
#ADD conf.d-ssl.conf.erb /etc/nginx/conf.d/ssl.conf.erb
#ADD conf.d-default.conf.erb /etc/nginx/conf.d/default.conf.erb
#ADD default.d-www.conf.erb /etc/nginx/default.d/www.conf.erb
#ADD sites.map /etc/nginx/sites.map


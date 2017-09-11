FROM amazonlinux:latest

ENV PATCHDATE 20170712
RUN yum -y update && yum clean all

RUN yum install -y httpd24 mod24_ssl ruby && yum clean all

ADD files/run-httpd.sh /usr/sbin/run-httpd.sh

CMD /usr/sbin/run-httpd.sh

EXPOSE 80
EXPOSE 443

RUN mkdir /var/www/html/server /var/lib/httpd  \
  && chmod 755 /usr/sbin/run-httpd.sh \
  && rm /etc/httpd/conf.modules.d/00-dav.conf /etc/httpd/conf.modules.d/00-lua.conf \
  && rm /etc/httpd/conf.d/userdir.conf /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/autoindex.conf

# the following two volumes are so we can do a handful of read-write things in controled situations
VOLUME /tmp
VOLUME /var/lib/httpd
VOLUME /var/run/httpd

VOLUME /var/log/httpd
VOLUME /etc/pki/httpd

ADD files/healthcheck /var/www/html/server/healthcheck

ADD files/get-cloudfront-ip.rb /usr/sbin/get-cloudfront-ip.rb
ADD files/ip-ranges.json /etc/httpd/ip-ranges.json
ADD files/httpd.conf /etc/httpd/conf/httpd.conf

COPY files/conf.modules.d/ /etc/httpd/conf.modules.d

COPY files/conf.d/ /etc/httpd/conf.d

ADD files/sitemap.txt /etc/httpd/sitemap.txt

RUN /usr/bin/httxt2dbm -f db -i /etc/httpd/sitemap.txt -o /etc/httpd/sitemap.db


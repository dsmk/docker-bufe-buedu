FROM amazonlinux:latest

ENV PATCHDATE 20170712
RUN yum -y update && yum clean all

#RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

#RUN yum -y install --setopt=tsflags=nodocs epel-release && yum clean all

RUN yum install -y nginx ruby && yum clean all

ADD files/run-nginx.sh /usr/sbin/run-nginx.sh

RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
  && chmod 755 /usr/sbin/run-nginx.sh \
  && mkdir -p /etc/erb/nginx/conf.d /etc/erb/nginx/default.d \
  && ln -sf /dev/stderr /var/log/nginx/error.log \
  && ln -sf /dev/stdout /var/log/nginx/access.log 

EXPOSE 80 443

VOLUME [ "/var/log/nginx", "/etc/pki/nginx" ]
# these are so we can run nginx read-only
VOLUME [ "/var/lib/nginx", "/tmp", "/var/run", "/var/log/nginx", "/etc/nginx" ]

CMD /usr/sbin/run-nginx.sh
ADD files/get-cloudfront-ip.rb /usr/sbin/get-cloudfront-ip.rb
ADD files/nginx.conf.erb /etc/erb/nginx/nginx.conf.erb
ADD files/conf.d-map-def.conf.erb /etc/erb/nginx/conf.d/map-def.conf.erb
ADD files/conf.d-ssl.conf.erb /etc/erb/nginx/conf.d/ssl.conf.erb
ADD files/conf.d-default.conf.erb /etc/erb/nginx/conf.d/default.conf.erb
ADD files/default.d-www.conf.erb /etc/erb/nginx/default.d/www.conf.erb
ADD files/sites.map /etc/nginx/sites.map


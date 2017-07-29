#!/bin/sh
#
# Run this script to generate the nginx.conf from nginx.conf.erb
#
if [ "x$LANDSCAPE" = "x" ]; then
  LANDSCAPE="test"
  export LANDSCAPE
fi

# update the cloudfront_ips.conf file used for getting the client IP when using cloudfront
/usr/sbin/get-cloudfront-ip.rb >/etc/nginx/cloudfront_ips.conf

# generate self-signed SSL certificates if they do not actually exist
if [ ! -f /etc/pki/nginx/cert.key ]; then
  set -x 
  cd /etc/pki/nginx
  openssl req -x509 -newkey rsa:4096 -keyout cert.key -out cert.pem -days 365 -nodes -subj "/C=US/ST=Massachusetts/L=Boston/O=Boston University/CN=internal-${LANDSCAPE}.domain"
  set +x
  ls -l /etc/pki/nginx
fi

# this is where we would load the first map files
# look through the common configuration files and run erb to 
FILES="nginx.conf conf.d/map-def.conf conf.d/ssl.conf conf.d/default.conf default.d/www.conf"

for file in $FILES ; do
  fullfile="/etc/nginx/$file"
  if [ -e "${fullfile}.erb" ]; then
    echo "erb substitutions for $fullfile"
    /usr/bin/erb "${fullfile}.erb" >$fullfile
  fi
done

echo "Starting nginx"
exec /usr/sbin/nginx 

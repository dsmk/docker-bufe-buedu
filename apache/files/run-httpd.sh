#!/bin/sh -x

echo "starting"

#set -e

# get the CloudFront IP addresses
TMPCONFDIR=/tmp
export TMPCONFDIR
#if curl -o "${TMPCONFDIR}/ip-ranges.json" "https://ip-ranges.amazonaws.com/ip-ranges.json" ; then
#  echo "bootstrap-cloudfront: got the URL for the latest ips"
#else
  echo "bootstrap-cloudfront: did not get the URL, using backup ips"
  cp /etc/httpd/ip-ranges.json "$TMPCONFDIR"
#fi
/usr/sbin/get-cloudfront-ip.rb "${TMPCONFDIR}/ip-ranges.json" >"${TMPCONFDIR}/ip-ranges.conf"


# Apache gets grumpy about PID files pre-existing
#?

exec /usr/sbin/httpd -D FOREGROUND

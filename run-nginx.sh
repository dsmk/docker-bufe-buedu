#!/bin/sh
#
# Run this script to generate the nginx.conf from nginx.conf.erb
#
if [ "x$LANDSCAPE" = "x" ]; then
  LANDSCAPE="test"
  export LANDSCAPE
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

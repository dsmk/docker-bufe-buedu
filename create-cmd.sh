#!/bin/sh
#
# We are building a container for each landscape bound to the same main ports
#
docker_image="nginx"
logdir="${PWD}/logs"
if [ ! -d "$logdir" ]; then
  mkdir "$logdir"
fi

proxy_nginx () {
  # make certain that we have a log directory for stuff
  my_land="$1"
  my_name="bufe-buedu-$my_land"
  my_logs="${logdir}/$my_land"
  if [ ! -d "$my_logs" ]; then
    echo "Creating $my_logs log directory"
    mkdir "$my_logs"
  fi

  echo "Creating $my_name container"
  docker create \
    -p 80:80 -p 443:443 \
    --env-file="${PWD}/${my_land}.env" \
    -h "$my_name" \
    -v "${my_logs}:/var/log/nginx" \
    --name="$my_name" \
    "$docker_image"
    #-v "${PWD}/pki/${my_land}:/etc/pki/nginx:ro" \
}

proxy_nginx test
#proxy_nginx prod
#proxy_nginx qa

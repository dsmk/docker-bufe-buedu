#!/bin/bash
#
# Run this script to generate load on the backend system
#

# variables
if [ "x$URLHOST" = x ]; then
  if [ "x$1" = x ]; then
    URLHOST="localhost:80"
  else
    URLHOST="$1"
  fi
fi

if [ "x$URI" = x ]; then
  if [ "x$2" = x ]; then
    URI="/server/healthcheck"
  else
    URI="$2"
  fi
fi

if [ "x$SCHEME" = x ]; then
  if [ "x$3" = x ]; then
    SCHEME="http"
  else
    SCHEME="$3"
  fi
fi

if [ "x$THREADS" = x ]; then
  THREADS="1800"
fi

if [ "x$TIMES" = x ]; then
  TIMES="180000"
fi

if [ "x$ARGS" = x ]; then
  ARGS=""
fi

ulimit -n 2048

if ./wait-for-it.sh "$URLHOST" ; then
  ab -c "$THREADS" -n "$TIMES" $ARGS "$SCHEME://${URLHOST}$URI"
else
  echo "The remote port $URLHOST is not responding"
fi

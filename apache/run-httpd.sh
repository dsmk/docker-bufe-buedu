#!/bin/sh

set -e

# Apache gets grumpy about PID files pre-existing
#?

exec /usr/sbin/httpd -D FOREGROUND

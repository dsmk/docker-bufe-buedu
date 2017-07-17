#!/bin/sh

/wait-for-it.sh bufe-autotest:80

source /sh2ju.sh
juLogClean

juLog -name="opentcp-80" nc -zv -w 10 bufe-autotest 80
juLog -name="opentcp-443" nc -zv -w 10 bufe-autotest 443


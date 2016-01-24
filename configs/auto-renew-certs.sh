#!/bin/sh
if ! /opt/letsencrypt/letsencrypt-auto certonly -vv \
  --keep-until-expiring --webroot -w /var/www/ \
  -d parkerly.com -d www.parkerly.com \
  > /var/log/letsencrypt/renew.log 2>&1 ; then
    echo Automated renewal failed:
    cat /var/log/letsencrypt/renew.log
    exit 1
fi
service apache2 restart

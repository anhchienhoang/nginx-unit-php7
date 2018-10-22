#!/bin/sh

PHP_CONFIG_DIR=$(php-config --configure-options | sed -n 's/.*with-config-file-scan-dir=\(.*\)/\1/p' | awk -F' ' '{print $1}');

cp /php.ini ${PHP_CONFIG_DIR}/php.ini

/opt/unit/sbin/unitd --control unix:/var/run/control.unit.sock

curl -X PUT --data-binary @/config.json --unix-socket /run/control.unit.sock http://localhost/config

tail -f /var/log/unit.log

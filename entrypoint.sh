#!/bin/sh

/opt/unit/sbin/unitd --control unix:/var/run/control.unit.sock

curl -X PUT --data-binary @/config.json --unix-socket /run/control.unit.sock http://localhost/config

tail -f /var/log/unit.log

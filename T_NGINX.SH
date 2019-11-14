#!/bin/bash

requeststps() {

/bin/cat /usr/local/zabbix/etc/scripts/request.txt
/bin/touch /usr/local/zabbix/etc/scripts/flag.txt
}

$1

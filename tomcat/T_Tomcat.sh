#!/bin/bash
port=$2
requeststps() {

/bin/cat /usr/local/zabbix/etc/scripts/requesttomcat.txt
/bin/touch /usr/local/zabbix/etc/scripts/tomcatflag.txt
}

$1
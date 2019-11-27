#!/bin/bash
x=0
c=-9
while true
do
  curl --connect-timeout 5 -s  http://127.0.0.1:80/ngx_status > /dev/null
  if [ $? -ne 0 ];then
     echo "$c" > request.txt
     break
  fi

  if [ ! -n "$a" ];then
     a=`wget -O- -q -t 3 -T 3  3  http://127.0.0.1:80/ngx_status |awk 'NR==3 {print $3}'`
  else
     a=${a}
  fi

  sleep 1
  a1=`wget -O- -q -t 3 -T 3  3  http://127.0.0.1:80/ngx_status |awk 'NR==3 {print $3}'`

  if [ ${x} -eq 0 ];then
    y=`expr ${a1} - ${a}`
    a=${a1}
    x=${y}
    echo "${y}" > request.txt 
  else
    y=`expr ${a1} - ${a}`
    if [[ ${y} -gt ${x} ]];then
       echo "${y}" > request.txt
       x=${y}
       a=${a1}
    else
       echo "${x}" > request.txt
       x=${x}
       a=${a1}
    fi
  fi
  if [ -f /usr/local/zabbix/etc/scripts/flag.txt ];then
       x=0
       rm flag.txt
  else
       x=$x
  fi
done

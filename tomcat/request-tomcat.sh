#!/bin/bash
x=0
c=-9
while true
do
  b=`curl -s -u migutomcat:migu1qaz!QAZ http://localhost:8082/manager/status|sed 's#</p>#\n#g'|grep "http-18083"|awk '{print $(NF-11)}'`
  if [ -z $b ];then
     echo "$c" > requesttomcat.txt
     break
  fi

  if [ ! -n "$a" ];then
     a=`curl -s -u migutomcat:migu1qaz!QAZ http://localhost:8082/manager/status|sed 's#</p>#\n#g'|grep "http-18083"|awk '{print $(NF-11)}'`
  else
     a=${a}
  fi

  sleep 1
  a1=`curl -s -u migutomcat:migu1qaz!QAZ http://localhost:8082/manager/status|sed 's#</p>#\n#g'|grep "http-18083"|awk '{print $(NF-11)}'`

  if [ ${x} -eq 0 ];then
    y=`expr ${a1} - ${a}`
    a=${a1}
    x=${y}
    echo "${y}" > requesttomcat.txt 
  else
    y=`expr ${a1} - ${a}`
    if [[ ${y} -gt ${x} ]];then
       echo "${y}" > requesttomcat.txt
       x=${y}
       a=${a1}
    else
       echo "${x}" > requesttomcat.txt
       x=${x}
       a=${a1}
    fi
  fi
  if [ -f /usr/local/zabbix/etc/scripts/tomcatflag.txt ];then
       x=0
       rm tomcatflag.txt
  else
       x=$x
  fi
done

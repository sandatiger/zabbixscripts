tomcat_tps监控修改说明（scsp,vas）：
需上传文件（manager.tar.gz，request-tomcat.sh，T_Tomcat.sh）
1.将manager.tar.gz上传至服务器解压至/tomcat/webapps/目录下解压（具体目录根据TOMCAT应用来，webapps目录下）（/tomcat/webapps/目录下无该目录时操作）
2.将request-tomcat.sh,T_Tomcat.sh两文件放置/usr/local/zabbix/etc/scripts/目录下（具体目录根据zabbix应用来）
（其中request-tomcat.sh脚本里的端口信息根据实际情况进行修改）
3.修改配置文件：/tomcat/conf/tomcat-users.xml（具体目录根据TOMCAT应用来）
4.添加配置：
<tomcat-users>
<user username="migutomcat" password="migu1qaz!QAZ" roles="manager-gui"/>
</tomcat-users>
5.修改配置文件：/tomcat/conf/Catalina/localhost/manager.xml
6.添加配置信息：
<Context privileged="true" antiResourceLocking="false"
         docBase="${catalina.home}/webapps/manager">
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.0\.0\.1" />
</Context> 

7.重启TOMCAT服务，查看curl -s -u migutomcat:'migu1qaz!QAZ' http://127.0.0.1:8080/manager/status是否有数据
8.curl -s -u migutomcat:'migu1qaz!QAZ' http://127.0.0.1:8080/manager/status|sed 's#</p>#\n#g'|grep "http-bio-8080"|awk '{print $(NF-11)}'再查看一下结果是否有数据
9.后台脚本：/usr/local/zabbix/etc/scripts/request-tomcat.sh &
10.脚本目录赋权：chmod 777 -R /usr/local/zabbix/etc/scripts/
11.修改zabbix配置文件zabbix_agentd.conf参数：UnsafeUserParameters=1
12.修改zabbix配置文件zabbix_agentd.conf,增加参数：Include=/usr/local/zabbix/zabbix_agentd.conf.d/*.conf（路径以服务器实际文件地址为准）
13.修改zabbix配置文件/usr/local/zabbix/zabbix_agentd.conf.d/userparameter_tomcat.conf(文件没有可增加，目录以实际进行修改)，
增加参数：UserParameter=Tcat.status[*],/usr/local/zabbix/etc/scripts/T_Tomcat.sh $1
14.重启zabbix-agent
15.然后再用zabbix_get 命令进行检测/usr/local/zabbix/bin/zabbix_get -s 127.0.0.1 -p 10050 -k Tcat.status[requeststps]是否正确接收到数据
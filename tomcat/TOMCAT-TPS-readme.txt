tomcat_tps����޸�˵����scsp,vas����
���ϴ��ļ���manager.tar.gz��request-tomcat.sh��T_Tomcat.sh��
1.��manager.tar.gz�ϴ�����������ѹ��/tomcat/webapps/Ŀ¼�½�ѹ������Ŀ¼����TOMCATӦ������webappsĿ¼�£���/tomcat/webapps/Ŀ¼���޸�Ŀ¼ʱ������
2.��request-tomcat.sh,T_Tomcat.sh���ļ�����/usr/local/zabbix/etc/scripts/Ŀ¼�£�����Ŀ¼����zabbixӦ������
������request-tomcat.sh�ű���Ķ˿���Ϣ����ʵ����������޸ģ�
3.�޸������ļ���/tomcat/conf/tomcat-users.xml������Ŀ¼����TOMCATӦ������
4.������ã�
<tomcat-users>
<user username="migutomcat" password="migu1qaz!QAZ" roles="manager-gui"/>
</tomcat-users>
5.�޸������ļ���/tomcat/conf/Catalina/localhost/manager.xml
6.���������Ϣ��
<Context privileged="true" antiResourceLocking="false"
         docBase="${catalina.home}/webapps/manager">
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.0\.0\.1" />
</Context> 

7.����TOMCAT���񣬲鿴curl -s -u migutomcat:'migu1qaz!QAZ' http://127.0.0.1:8080/manager/status�Ƿ�������
8.curl -s -u migutomcat:'migu1qaz!QAZ' http://127.0.0.1:8080/manager/status|sed 's#</p>#\n#g'|grep "http-bio-8080"|awk '{print $(NF-11)}'�ٲ鿴һ�½���Ƿ�������
9.��̨�ű���/usr/local/zabbix/etc/scripts/request-tomcat.sh &
10.�ű�Ŀ¼��Ȩ��chmod 777 -R /usr/local/zabbix/etc/scripts/
11.�޸�zabbix�����ļ�zabbix_agentd.conf������UnsafeUserParameters=1
12.�޸�zabbix�����ļ�zabbix_agentd.conf,���Ӳ�����Include=/usr/local/zabbix/zabbix_agentd.conf.d/*.conf��·���Է�����ʵ���ļ���ַΪ׼��
13.�޸�zabbix�����ļ�/usr/local/zabbix/zabbix_agentd.conf.d/userparameter_tomcat.conf(�ļ�û�п����ӣ�Ŀ¼��ʵ�ʽ����޸�)��
���Ӳ�����UserParameter=Tcat.status[*],/usr/local/zabbix/etc/scripts/T_Tomcat.sh $1
14.����zabbix-agent
15.Ȼ������zabbix_get ������м��/usr/local/zabbix/bin/zabbix_get -s 127.0.0.1 -p 10050 -k Tcat.status[requeststps]�Ƿ���ȷ���յ�����
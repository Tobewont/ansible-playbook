#!/bin/bash
#该脚本用于zabbix数据库配置

passwd={{ MYSQL_PASSWD }}
n=`grep "{{ BASE_DIR }}/bin" /etc/profile |wc -l`

if [ $n -eq 0 ]
then
        echo "export PATH=$PATH:{{ BASE_DIR }}/bin" >> /etc/profile
        source /etc/profile
else
        source /etc/profile
fi

{{ BASE_DIR }}/bin/mysql -uroot -p$passwd -e "create database zabbix character set utf8;"

{{ BASE_DIR }}/bin/mysql -uroot -p$passwd -e "grant all on zabbix.* to 'zabbix'@'%' identified by '$passwd';"

{{ BASE_DIR }}/bin/mysql -uroot -p$passwd -e "FLUSH PRIVILEGES;"

cd `find / -name zabbix-server-mysql*` && gzip -d create.sql.gz 

{{ BASE_DIR }}/bin/mysql -uroot -S {{ BASE_DIR }}/tmp/mysql.sock -p{{ MYSQL_PASSWD }} zabbix < create.sql

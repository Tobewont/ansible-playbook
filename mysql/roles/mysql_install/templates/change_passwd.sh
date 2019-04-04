#!/bin/bash
#该脚本用于更改数据库root密码

passwd={{ MYSQL_PASSWD }}
n=`grep "{{ BASE_DIR }}/bin" /etc/profile |wc -l`

if [ $n -eq 0 ]
then
        echo "export PATH=$PATH:{{ BASE_DIR }}/bin" >> /etc/profile
        source /etc/profile
else
        source /etc/profile
fi

{{ BASE_DIR }}/bin/mysql -uroot -D mysql -e "UPDATE user SET authentication_string=PASSWORD("$passwd") WHERE user='root';"

{{ BASE_DIR }}/bin/mysql -uroot -e "FLUSH PRIVILEGES;"

{{ BASE_DIR }}/bin/mysql -uroot -p$passwd -e "grant all privileges on *.* to root@'%'  identified by '$passwd';"

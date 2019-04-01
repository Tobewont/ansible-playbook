#!/bin/bash
#该脚本用于更改数据库root密码

passwd=123456789
n=`grep "/usr/local/mysql/bin" /etc/profile |wc -l`

if [ $n -eq 0 ]
then
        echo "export PATH=$PATH:/usr/local/mysql/bin" >> /etc/profile
        source /etc/profile
else
        source /etc/profile
fi

/usr/local/mysql/bin/mysql -uroot -D mysql -e "UPDATE user SET authentication_string=PASSWORD("$passwd") WHERE user='root';"

/usr/local/mysql/bin/mysql -uroot -e "FLUSH PRIVILEGES;"

/usr/local/mysql/bin/mysql -uroot -p$passwd -e "grant all privileges on *.* to root@'%'  identified by '$passwd';"

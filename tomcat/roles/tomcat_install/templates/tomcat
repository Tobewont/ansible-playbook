#!/bin/sh
# chkconfig: 345 99 10
# description: Auto-starts tomcat
# /etc/init.d/tomcatd
# Tomcat auto-start
# Source function library.
#. /etc/init.d/functions
# source networking configuration.
#. /etc/sysconfig/network
prog="tomcat"
RETVAL=0

CATALINA_HOME={{ TOMCAT_DIR }}

start()
{
        if [ -f $CATALINA_HOME/bin/startup.sh ];
          then
            echo $"Starting $prog"
                $CATALINA_HOME/bin/startup.sh
            RETVAL=$?
            echo " OK"
            return $RETVAL
        fi
}
stop()
{
        if [ -f $CATALINA_HOME/bin/shutdown.sh ];
          then
            echo $"Stopping $prog"
                $CATALINA_HOME/bin/shutdown.sh
            RETVAL=$?
            #sleep 1
            ps -ef |grep $CATALINA_HOME |grep -v grep |grep -v PID | awk '{print $2}'|xargs kill -9
            echo " OK"
            # [ $RETVAL -eq 0 ] && rm -f /var/lock/...
            return $RETVAL
        fi
}
case "$1" in
 start)
        start
        ;;
 stop)
        stop
        ;;
 restart)
         echo $"Restaring $prog"
         $0 stop && sleep 1 && $0 start
         ;;
 *)
        echo $"Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
exit $RETVAL

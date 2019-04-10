#! /bin/bash
echo 1 > /proc/sys/net/ipv4/ip_forward

ipv=/usr/sbin/ipvsadm
vip={{ VIP_IP}}
rs1={{ MASTER_IP }}
rs2={{ BACKUP1_IP }}
rs3={{ BACKUP2_IP }}

ifdown {{ INF }}
ifup {{ INF }}
ifconfig {{ INF }}:1 $vip broadcast $vip netmask 255.255.255.255 up
route add -host $vip dev {{ INF }}:1

$ipv -C
$ipv -A -t $vip:{{ NGINX_PORT }} -s {{ SA }}
$ipv -a -t $vip:{{ NGINX_PORT }} -r $rs1:{{ NGINX_PORT }} -g -w 1
$ipv -a -t $vip:{{ NGINX_PORT }} -r $rs2:{{ NGINX_PORT }} -g -w 1
$ipv -a -t $vip:{{ NGINX_PORT }} -r $rs3:{{ NGINX_PORT }} -g -w 1

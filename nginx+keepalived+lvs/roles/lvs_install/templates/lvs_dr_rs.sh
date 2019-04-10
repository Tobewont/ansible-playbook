#/bin/bash
vip={{ VIP_IP}}

#把vip绑定在lo上，实现real_server直接把结果返回给客户端
ifdown lo
ifup lo
ifconfig lo:0 $vip broadcast $vip netmask 255.255.255.255 up
route add -host $vip lo:0

#更改arp内核参数，让real_server顺利发送mac地址给客户端

echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce

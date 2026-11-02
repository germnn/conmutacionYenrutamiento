------------------------------------Torre UNO DHCP
enable
configure terminal
hostname UNO
no ip domain-lookup
banner motd #Solo personal autorizado# 

ipv6 unicast-routing

int GIG0/0
ip add 131.16.6.1 255.255.255.224
ipv6 address A:B::1/64
ipv6 address FE80::1 link-local
no shutdown

ip dhcp pool DHCP-POOL-LAN1
default-router 131.16.6.1
network 131.16.6.0 255.255.255.224
ip dhcp excluded-address 131.16.6.1 131.16.6.2

int Se0/3/1
description Red Wan T1-T2
ip add 192.168.1.5 255.255.255.252
ipv6 address CAFE:1::5/64
ipv6 address FE80::1 link-local
clock rate 128000
no shut
exit

interface loopback1
description Red LoopBack500
ip add 131.16.4.1 255.255.254.0
ipv6 address A:C::1/64
ipv6 address FE80::1 link-local
exit

interface loopback2
description Red LoopBack1000
ip add 131.16.0.1 255.255.252.0
ipv6 address A:A::1/64
ipv6 address FE80::1 link-local
exit

IP ROUTE 0.0.0.0 0.0.0.0 se0/3/1
IPV6 ROUTE ::/0 se0/3/1

============================S1
enable
conf term
hostname S1
int VLAN1
Ip add 131.16.6.2 255.255.255.224
no shut
ip default-gateway 131.16.6.1



=============================SSH Router SSH
-----------------------------Torre 2
enable
configure terminal
hostname T2-SSH-DHCP
no ip domain-lookup
ip domain-name cisco.com
===Se recomienda usar 1024
crypto key generate rsa
ip ssh version 2
ip ssh time-out 60
ip ssh authentication-retries 2
line vty 0 4
login local
transport input ssh
username ADMIN privilege 15 secret cisco111
username REMOTO privilege 1 secret cisco222

=====Realizar pruebas de SSH desde el PC
ssh -l ADMIN 192.168.1.1
=====Revision de conexion SSH en el Switch ssh
show ip ssh
show crypto key mypubkey rsa
show ssh

====================================
ipv6 unicast-routing
int GIG0/0
description Red Lan de T2-T5
ip add 192.168.1.1 255.255.255.252
ipv6 address CAFE:5::1/64
ipv6 address FE80::2 link-local
no shutdown
exit

int Se0/0/0
description Red Wan T2-T1
ip add 192.168.1.6 255.255.255.252
ipv6 address CAFE:1::2/64
ipv6 address FE80::2 link-local
no shut
exit

interface loopback1
description Red LoopBack500
ip add 142.16.0.1 255.255.254.0
ipv6 address A1:1::1/64
ipv6 address FE80::2 link-local
exit

interface loopback2
description Red LoopBack300
ip add 142.16.2.1 255.255.254.0
ipv6 address A1:2::1/64
ipv6 address FE80::2 link-local
exit

int Se0/0/1
description Red Wan T2-T3
ip add 192.168.1.9 255.255.255.252
ipv6 address CAFE:3::1/64
ipv6 address FE80::2 link-local
clock rate 128000
no shut
exit

ENRUTAMIENTO T2 
  
Ip route 131.16.0.0 255.255.248.0 se0/0/0 
Ipv6 route A:8::/29 se0/0/0

Ip route 172.16.0.0 255.255.254.0 se0/0/1
Ipv6 route D:B00::/26 se0/0/1

Ip route 132.16.0.0 255.255.248.0 GIG0/0
Ipv6 route B::/30 GIG0/0

Ipv6 route B1::/30 GIG0/0
Ip route 152.16.0.0 255.255.248.0 GIG0/0
 
Ip route 182.16.0.0 255.255.254.0 GIG0/0
Ipv6 route C:B00::/26 GIG0/0

ip route 192.168.1.12 255.255.255.252 g0/0
ip route 192.168.1.16 255.255.255.252 g0/0

ipv6 route CAFE:4::/64 g0/0
ipv6 route CAFE:2::/64 g0/0


------------------------------------Torre TRES
enable
configure terminal
hostname TRES
no ip domain-lookup
banner motd #Solo personal autorizado# 
ipv6 unicast-routing

int GIG0/0
ip add 172.16.0.1 255.255.255.0
ipv6 address D:B10::1/64
ipv6 address FE80::3 link-local
no shutdown

ip dhcp pool DHCP-POOL-LAN3
default-router 172.16.0.1
network 172.16.0.0 255.255.255.0
ip dhcp excluded-address 172.16.0.1 172.16.0.2


int Se0/0/0
description Red Wan T3-T2
ip add 192.168.1.10 255.255.255.252
ipv6 address CAFE:3::2/64
ipv6 address FE80::3 link-local
no shut
exit

interface loopback1
description Red LoopBack500
ip add 172.16.1.1 255.255.255.0
ipv6 address D:B20::1/64
ipv6 address FE80::3 link-local
exit

IP ROUTE 0.0.0.0 0.0.0.0 se0/0/0

IPV6 ROUTE ::/0 se0/0/0

============================S3
enable
conf term
hostname S3
int VLAN1
Ip add 172.16.0.2 255.255.255.0
no shut
ip default-gateway 172.16.0.1


------------------------------------Torre CUATRO
enable
configure terminal
hostname CUATRO
no ip domain-lookup
banner motd #Solo personal autorizado# 

ipv6 unicast-routing

int GIG0/0
ip add 132.16.4.1 255.255.255.224
ipv6 address B:2::1/64
ipv6 address FE80::4 link-local
no shutdown

ip dhcp pool DHCP-POOL-LAN4
default-router 132.16.4.1
network 132.16.4.0 255.255.255.224
ip dhcp excluded-address 132.16.4.1 132.16.4.2


int Se0/0/0
description Red Wan T4-T5
ip add 192.168.1.17 255.255.255.252
ipv6 address CAFE:2::1/64
ipv6 address FE80::4 link-local
clock rate 128000
no shut
exit

interface loopback1
description Red LoopBack500
ip add 132.16.0.1 255.255.254.0
ipv6 address B:1::1/64
ipv6 address FE80::4 link-local
exit

interface loopback2
description Red LoopBack300
ip add 132.16.2.1 255.255.254.0
ipv6 address B:3::1/64
ipv6 address FE80::4 link-local
exit

IP ROUTE 0.0.0.0 0.0.0.0 se0/0/0

IPV6 ROUTE ::/0 se0/0/0

============================S4
enable
conf term
hostname S3
int VLAN1
Ip add 132.16.4.2 255.255.255.224
no shut
ip default-gateway 132.16.4.1



=============================SSH Router SSH
-----------------------------Torre 5
enable
configure terminal
hostname T5-SSH-DHCP
no ip domain-lookup

ip domain-name cisco.com
===Se recomienda usar 1024
crypto key generate rsa
ip ssh version 2
ip ssh time-out 60
ip ssh authentication-retries 2
line vty 0 4
login local
transport input ssh
username ADMIN privilege 15 secret cisco111
username REMOTO privilege 1 secret cisco222

=====Realizar pruebas de SSH desde el PC
ssh -l REMOTO 192.168.1.2
=====Revision de conexion SSH en el Switch ssh
show ip ssh
show crypto key mypubkey rsa
show ssh
=========================

ipv6 unicast-routing
int GIG0/0
ip add 192.168.1.2 255.255.255.252
ipv6 address CAFE:5::2/64
ipv6 address FE80::5 link-local
no shutdown
exit

int Se0/0/1
description Red Wan T5-T4
ip add 192.168.1.18 255.255.255.252
ipv6 address CAFE:2::2/64
ipv6 address FE80::5 link-local
clock rate 128000
no shut
exit

interface loopback1
description Red LoopBack300
ip add 152.16.4.1 255.255.254.0
ipv6 address B1:1::1/64
ipv6 address FE80::5 link-local
exit

interface loopback2
description Red LoopBack600
ip add 152.16.0.1 255.255.252.0
ipv6 address B1:2::1/64
ipv6 address FE80::5 link-local
exit

int Se0/0/0
description Red Wan T5-T6
ip add 192.168.1.13 255.255.255.252
ipv6 address CAFE:4::1/64
ipv6 address FE80::5 link-local
clock rate 128000
no shut
exit


ENRUTAMIENTO T5 

T1  
Ip route 131.16.0.0 255.255.248.0 GIG0/0
Ipv6 route A:8::/29 GIG0/0

Ip route 142.16.0.0 255.255.248.0 GIG0/0
Ipv6 route A1::/30 GIG0/0

 
Ip route 172.16.0.0 255.255.254.0 GIG0/0
Ipv6 route D:B00::/26 GIG0/0

 
Ip route 132.16.0.0 255.255.248.0 se0/0/1
Ipv6 route B::/30 se0/0/1

 
Ip route 182.16.0.0 255.255.254.0 se0/0/0
Ipv6 route C:B00::/26 se0/0/0

ip route 192.168.1.4 255.255.255.252 g0/0
ip route 192.168.1.8 255.255.255.252 g0/0

ipv6 route CAFE:1::/64 g0/0
ipv6 route CAFE:3::/64 g0/0


------------------------------------Torre SEIS
enable
configure terminal
hostname SEIS
no ip domain-lookup
banner motd #Solo personal autorizado# 

ipv6 unicast-routing

int GIG0/0
ip add 182.16.0.1 255.255.255.0
ipv6 address C:B10::1/64
ipv6 address FE80::6 link-local
no shutdown

ip dhcp pool DHCP-POOL-LAN4
default-router 182.16.0.1
network 182.16.0.0 255.255.255.0
ip dhcp excluded-address 182.16.0.1 182.16.0.2


int Se0/0/1
description Red Wan T6-T5
ip add 192.168.1.14 255.255.255.252
ipv6 address CAFE:4::2/64
ipv6 address FE80::6 link-local
no shut
exit

interface loopback1
description Red LoopBack500
ip add 182.16.1.1 255.255.255.0
ipv6 address C:B20::1/64
ipv6 address FE80::6 link-local
exit

IP ROUTE 0.0.0.0 0.0.0.0 se0/0/1

IPV6 ROUTE ::/0 se0/0/1

============================S6
enable
conf term
hostname S6
int VLAN1
Ip add 182.16.0.2 255.255.255.0
no shut
ip default-gateway 182.16.0.1








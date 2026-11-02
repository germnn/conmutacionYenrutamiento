============ROUTER CDMX
enable
configure terminal
no ip domain-lookup
hostname CDMX
banner motd #Solo personal autorizado#
Enable pass cisco
Line console 0 
Pass cisco
Login
Line vty 0 4
Pass cisco
Login

-------Interfaces
int s0/1/0
ip add 10.0.0.2 255.255.255.252
clock rate 128000
no shut
exit

int fa0/0
ip add 200.33.16.1 255.255.255.0
no shut
exit


================SWITCH SSH
enable
configure terminal
hostname SSH
no ip domain-lookup

Interface vlan1
ip add 200.33.16.2 255.255.255.0
no shut
ip default-gateway 200.33.16.1
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
ssh -l REMOTO 200.33.16.2
=====Revision de conexion SSH en el Switch ssh
show ip ssh
show crypto key mypubkey rsa
show ssh


======= CONFIGURAR SERVIDOR DHCP
ENRUTAMIENTO CDMX
===========
IP ROUTE 0.0.0.0 0.0.0.0 10.0.0.1




============ROUTER CLN
enable
configure terminal
no ip domain-lookup
hostname CLN
Enable pass cisco
Line console 0
Pass cisco
Login
Line vty 0 4
Pass cisco
Login

-------Interfaces   DHCP para CLN

int fa0/0
ip address 172.16.0.1 255.255.0.0
ip dhcp pool DHCP-POOL-01
default-router 172.16.0.1
network 172.16.0.0 255.255.0.0
ip dhcp excluded-address 172.16.0.1 172.16.0.2
exit

-----ENRUTAMIENTO CLN para ambos router
========= ESTO NO
ROUTER RIP
VERSION 2
NO AUTO-SUMMARY
NETWORK 172.16.0.0
NETWORK 10.0.0.0
=======

===============SWITCH TELNET
Enable
configure terminal
no ip domain-lookup
hostname TELNET

int vlan1
ip add 172.16.0.2 255.255.0.0
no shut
ip default-gateway 172.16.0.1


username ADMIN privilege 15 secret CISCO1
username AUXILIAR secret CISCO2
line vty 0 4
exec-timeout 5 0
transport input telnet
login local
end

=====CONFIGURAR SERVIDOR DHCP

==== NO AHY ESA RED STEPHEN
=====PRUEBAS
C:\>ssh -l ADMIN 192.168.0.1

ssh admin@192.168.1.10

telnet 172.16.0.1


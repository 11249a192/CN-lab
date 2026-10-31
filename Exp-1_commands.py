ipconfig
ping google.com
tracert google.com
nslookup google.com
netstat
hostname
getmac
arp -a
tasklist
ipconfig
hostname
nslookup google.com

#output
C:\> ipconfig

Windows IP Configuration

Ethernet adapter Ethernet:
   IPv4 Address . . . . . . . . . : 192.168.1.5
   Subnet Mask . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . : 192.168.1.1


C:\> ping google.com

Pinging google.com [142.250.183.14] with 32 bytes of data:
Reply from 142.250.183.14: bytes=32 time=20ms TTL=117
Reply from 142.250.183.14: bytes=32 time=19ms TTL=117

C:\> tracert google.com

Tracing route to google.com
over a maximum of 30 hops:

1    2 ms    1 ms    2 ms    192.168.1.1
2   10 ms   12 ms   11 ms    ISP Gateway
3   20 ms   19 ms   21 ms    google.com

Trace complete.


C:\> nslookup google.com

Server:  dns.google
Address:  8.8.8.8

Name:    google.com
Address: 142.250.183.14


C:\> netstat

Active Connections

Proto  Local Address       Foreign Address       State
TCP    127.0.0.1:5000      127.0.0.1:5001         ESTABLISHED


C:\> hostname

DESKTOP-ABC123


C:\> getmac

Physical Address      Transport Name
00-0A-95-9D-68-16     \Device\Tcpip


C:\> arp -a

Interface: 192.168.1.5

Internet Address      Physical Address
192.168.1.1           00-0A-95-9D-68-16
192.168.1.2           00-0A-95-9D-68-17


C:\> tasklist

Image Name          PID
========================
System              4
explorer.exe        1234
chrome.exe          5678
notepad.exe         2345


C:\> ipconfig

Windows IP Configuration
IPv4 Address: 192.168.1.5


C:\> hostname

DESKTOP-ABC123


C:\> nslookup google.com

Name:    google.com
Address: 142.250.183.14

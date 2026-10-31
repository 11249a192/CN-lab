# Create simulator
set ns [new Simulator]

# Define colors
$ns color 1 Blue
$ns color 2 Red

# Open NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

# Finish procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam out.nam &
    exit 0
}

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

# Create links
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 1.7Mb 20ms DropTail

# Queue limit
$ns queue-limit $n2 $n3 10

# Link orientation (for NAM)
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n2 $n3 queuePos 0.5

# TCP setup
set tcp [new Agent/TCP]
$tcp set class_ 2
$tcp set fid_ 1

$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $tcp $sink

# FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

# UDP setup
set udp [new Agent/UDP]
$udp set fid_ 2
$ns attach-agent $n1 $udp

set null [new Agent/Null]
$ns attach-agent $n3 $null

$ns connect $udp $null

# CBR over UDP
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 1mb
$cbr set random_ false

# Scheduling events
$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 4.0 "$ftp stop"
$ns at 4.5 "$cbr stop"

# Detach agents
$ns at 4.5 "$ns detach-agent $n0 $tcp"
$ns at 4.5 "$ns detach-agent $n3 $sink"

# End simulation
$ns at 5.0 "finish"

# Print values
puts "CBR packet size = [$cbr set packet_size_]"
puts "CBR interval = [$cbr set interval_]"

# Run simulation
$ns run

#output
==============================================
          ARP AND RARP SIMULATOR
==============================================

========================================
ARP TABLE
========================================
IP Address              MAC Address
----------------------------------------
192.168.1.1              00:0a:95:9d:68:16
192.168.1.2              00:0a:95:9d:68:17
192.168.1.3              00:0a:95:9d:68:18

========== ARP EXAMPLES ==========

ARP REQUEST
ARP Request: Who has 192.168.1.1?
Tell me your MAC address.
ARP Reply: 192.168.1.1 is at 00:0a:95:9d:68:16.

ARP Reply: 192.168.1.2 is at 00:0a:95:9d:68:17.

ARP Reply: 192.168.1.100 is not found.

========== RARP EXAMPLES ==========

RARP Reply: 00:0a:95:9d:68:16 is associated with IP 192.168.1.1.

RARP Reply: 00:0a:95:9d:68:17 is associated with IP 192.168.1.2.

RARP Reply: 00:0a:95:9d:68:99 is not found.

========== ADD NEW ENTRY ==========

Entry added successfully.

IP  : 192.168.1.4
MAC : 00:0a:95:9d:68:19

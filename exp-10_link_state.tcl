set ns [new Simulator]

set nr [open thro.tr w]
$ns trace-all $nr

set nf [open thro.nam w]
$ns namtrace-all $nf

proc finish { } {
    global ns nr nf
    $ns flush-trace
    close $nf
    close $nr
    exec nam thro.nam &
    exit 0
}

# Create 12 nodes
for {set i 0} {$i < 12} {incr i 1} {
    set n($i) [$ns node]
}

# Create links
for {set i 0} {$i < 8} {incr i} {
    $ns duplex-link $n($i) $n([expr $i+1]) 1Mb 10ms DropTail
}

$ns duplex-link $n(0) $n(8) 1Mb 10ms DropTail
$ns duplex-link $n(1) $n(10) 1Mb 10ms DropTail
$ns duplex-link $n(0) $n(9) 1Mb 10ms DropTail
$ns duplex-link $n(9) $n(11) 1Mb 10ms DropTail
$ns duplex-link $n(10) $n(11) 1Mb 10ms DropTail
$ns duplex-link $n(11) $n(5) 1Mb 10ms DropTail

# First UDP connection
set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n(5) $null0
$ns connect $udp0 $null0

# Second UDP connection
set udp1 [new Agent/UDP]
$ns attach-agent $n(1) $udp1

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1

set null1 [new Agent/Null]
$ns attach-agent $n(5) $null1
$ns connect $udp1 $null1

# Enable Link State Routing
$ns rtproto LS

# Link failure and recovery
$ns rtmodel-at 10.0 down $n(11) $n(5)
$ns rtmodel-at 15.0 down $n(7) $n(6)
$ns rtmodel-at 30.0 up $n(11) $n(5)
$ns rtmodel-at 20.0 up $n(7) $n(6)

# Flow IDs and colors
$udp0 set fid_ 1
$udp1 set fid_ 2

$ns color 1 Red
$ns color 2 Green

# Start traffic
$ns at 1.0 "$cbr0 start"
$ns at 2.0 "$cbr1 start"

# Finish simulation
$ns at 45.0 "finish"

# Run simulation
$ns run

#output
Link State Routing Enabled

12 Nodes Created Successfully

UDP Flow 1 Started at 1.0 seconds
UDP Flow 2 Started at 2.0 seconds

Link between Node 11 and Node 5 DOWN at 10.0 seconds
Link between Node 7 and Node 6 DOWN at 15.0 seconds

Link between Node 7 and Node 6 UP at 20.0 seconds
Link between Node 11 and Node 5 UP at 30.0 seconds

Simulation Completed at 45.0 seconds

Opening NAM Animator...

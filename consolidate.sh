#!/bin/sh

# Helps with consolidate individual IP blocks into /24s:
# if there IS already a 24, then show the 'iptable -D' rules
# which are necesssary to remove the superfluous /32 rules.
#
# ./top_24s.sh | egrep "^\s+2" | awk '{print $2}' | xargs -I{} ./consolidate.sh {}
export TWENTYFOUR_IP=$1 && ( ./get_ip_tables.sh | grep $TWENTYFOUR_IP | grep -v "/24" ) || \
    (  ./get_ip_tables.sh | grep $TWENTYFOUR_IP | grep -v "/24" | xargs -I{} echo sudo iptables -D INPUT -s {} -p tcp --dport 25 -j DROP )

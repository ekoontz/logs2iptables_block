#!/bin/sh -e

NET=$1
ABUSE1=$(whois "$NET" | grep -i "Abuse Contact" | awk '{print $9}' | sed "s/'//g")
ABUSE2=$(whois "$NET" | grep -i "OrgAbuseEmail" | awk '{print $2}' | sed "s/'//g")

# Print with first column padded to 30 characters (adjust width as needed)
ABUSE=$(echo $ABUSE1 " " $ABUSE2 | sed "s/^ //" | sed "s/ +$//")
printf "%-30s %s\n" "$NET" "$ABUSE"


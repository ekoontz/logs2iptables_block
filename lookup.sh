#!/bin/sh -e

NET=$1
ABUSE=$(whois "$NET" | grep 'Abuse contact' | awk '{print $9}' | sed "s/'//g")

# Print with first column padded to 30 characters (adjust width as needed)
printf "%-30s %s\n" "$NET" "$ABUSE"

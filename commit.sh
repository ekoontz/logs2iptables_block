#!/bin/sh -ex

git diff | grep "+" | sed "s/+//" | grep -v "@" | grep -v "++" | sed "s/\/.*//" |\
    xargs -I{} bash -c "echo {}; echo "====="; whois {} | grep abuse | grep \"@\"; echo" |\
    git commit -F - block_these_ips.txt

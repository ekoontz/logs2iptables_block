./cat_logs.sh | grep "reject:" |\
    ./find_ip.pl | sort | uniq | \
    xargs -I{} bash -c "\
    sudo iptables -n -L INPUT | sort -k4 -n | awk '{print $4}'   | egrep {} || \
    echo sudo iptables -A INPUT -s {} -p tcp --dport 25 -j DROP | sort -n;
"

echo "starting.."
( (sudo cat /var/log/mail.log*) ; (sudo zcat /var/log/mail.log*.gz) ) | egrep "^.*reject|blocked.*" |\
    ./rejected_ips.pl  | sort -k2 -n | awk '{print $1}' | \
    xargs -I{} \
	  bash -c "\
    echo \"== {} ==\"; \
    echo; \
    sudo iptables -n -L INPUT | sort -k4 -n | awk '{print $4}'   | egrep {} || \
    echo sudo iptables -A INPUT -s {} -p tcp --dport 25 -j DROP | sort -n; echo
"
echo "done."


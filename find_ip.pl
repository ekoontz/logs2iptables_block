#!/usr/bin/perl -w

# sudo cat /var/log/mail.log | grep -i reject | perl -pe "s/.*\[(.*)\].*/\$1/"  | sort -n  | uniq -c  | sort -n^C

my %IPS;
my %DATES;
while(<>) {
    m/^(...) (..) (..):(..):(..).*\[(.*)\]:.*/;
    print "$6\n";
}



#!/usr/bin/perl -w

# sudo cat /var/log/mail.log | grep -i reject | perl -pe "s/.*\[(.*)\].*/\$1/"  | sort -n  | uniq -c  | sort -n^C

my %IPS;
my %DATES;
while(<>) {
    if ($_ =~ m/Client host rejected/) {
	m/^(...) (..) (..):(..):(..).*\[(.*)\].*/;
	my $month = $1;
	my $day = $2;	
	my $hour = $3;
	my $minute = $4;
	my $seconds = $5;
	my $ip = $6;
	$IPS{$ip}++;
	if (! exists($DATES{$ip})) {
	    $DATES{$ip} = [];
	}
	push @{$DATES{$ip}},"$month $day $hour:$minute:$seconds";
#	print "Now: $ip has dates: " . join(",",@{$DATES{$ip}}) . "\n";
    }
}

foreach $ip (sort { $IPS{$b} <=> $IPS{$a} || $a cmp $b } keys %IPS) {
    my @sorted = sort(@{$DATES{$ip}});
    my $first = $sorted[0];
    my $last = $sorted[$#sorted];
    print "$ip $IPS{$ip}; dates: [ $first - $last ]\n";
}



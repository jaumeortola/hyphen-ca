#!/usr/bin/perl
if (!defined $ARGV[1] || !defined $ARGV[0]) {
    print "" .
	"Write one rule per line\n".
	"usage: oneruleperline.pl inputfile outputfile\n";
    exit 1;
}
$fn = $ARGV[0];
open HYPH, $fn;
open OUT, ">$ARGV[1]";

my $line;
while (<HYPH>)
{
    $line=$_;	
    if ($line =~ /^[%{}\\]/) {
	#comment, ignore
    } 
    else {
     	chomp($line);
     	my @values = split(' ', $line);
	foreach my $val (@values) {
	    print OUT "$val\n";
	}
    }
}

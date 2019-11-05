$inputfile = "hyph-ca-new.tex";
$outputfile = "ca.js";

open(my $fh, "<", "$inputfile")
	or die "Can't open < $inputfile: $!";

open(my $ofh, ">", "$outputfile")
	or die "Can't open > $outputfile: $!";

while( my $line = <$fh>) {
	chomp $line;
	if ($line =~ /IGNORE/) {
		last;
	}
	$line =~ s/^%.*//;
	$line =~ s/^\\patterns.*//;
	$line =~ s/^\}.*//;
	my @patterns = split / +/, $line;
	foreach my $pattern (@patterns) {
		print $ofh '"'.$pattern.'", ';
	}
	if (@patterns) {
		print $ofh "\n";
	}
}
print $ofh '""'."\n";
close($fh);

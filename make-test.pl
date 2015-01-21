use TeX::Hyphen;

$file_simple_hyph = $ARGV[0];
$file_new_hyph = $ARGV[1];

my $hyp = new TeX::Hyphen 'file' => $file_simple_hyph, 'style' => 'catalan';
my $newhyp = new TeX::Hyphen 'file' => $file_new_hyph, 'style' => 'catalan';

print STDERR "Making hyphenation patterns tests...\n";

my $f1="errors-comuns.txt";
my $f2="errors-excepcions.txt";
my $f3="resum-resultats.txt";
open (FILE1, ">$f1") or die "Could not open file: $! \n";
open (FILE2, ">$f2") or die "Could not open file: $! \n";
open (FILE3, ">$f3") or die "Could not open file: $! \n";

my $wordCorrectHyphen="";
my $word="";
my $hsword="";
my $hcword="";
my $total=0;
my $excep=0;
my $excep_errors=0;
my $excep_correctes=0;
my $excep_errors_new=0;
my $excep_correctes_new=0;
my $comuns=0;
my $comuns_errors=0;
my $comuns_correctes=0;
while (my $line=<STDIN>) { 
	chomp($line);
	if ($line =~ /^([^ #]+) ?(.*)/)
	{
		$total++;
		$word=$1;
		$wordCorrectHyphen="";
		if ($2) {$wordCorrectHyphen=$2; $wordCorrectHyphen =~ s/-/_/g;}
		#simple rules hyphenation
		$hsword = $hyp->visualize($word);
		$hsword =~ s/·//g;
		$hsword =~ s/--/-/;
		$hsword =~ s/-/_/g;
		#new hyphenation
		$hcword = $newhyp->visualize($word);
		$hcword =~ s/·//g;
		$hcword =~ s/--/-/;
		$hcword =~ s/-/_/g;

		
		if ($wordCorrectHyphen=~ /.+/) {
			$excep++;
			if ($hsword =~ /^$wordCorrectHyphen$/)  {$excep_correctes++;}
			if ($hsword !~ /^$wordCorrectHyphen$/)  {$excep_errors++;}
			if ($hcword =~ /^$wordCorrectHyphen$/)  {$excep_correctes_new++;}
			if ($hcword !~ /^$wordCorrectHyphen$/)  {
				$excep_errors_new++;
				print FILE2 "$word $wordCorrectHyphen --> $hsword $hcword\n";
			}
			print "$word $wordCorrectHyphen --> $hsword $hcword\n";
                }
		else {
			$comuns++;
			if ($hcword =~ /^$hsword$/)  {$comuns_correctes++;}
			if ($hcword !~ /^$hsword$/)  {
				$comuns_errors++;
				print FILE1 "$word --> $hsword $hcword\n";
			}
			print "$word --> $hsword $hcword\n";
		}

	}
}
print FILE3 "Total=$total\n";
print FILE3 "Excepcions=$excep\n";
print FILE3 "Excepcions correctes=$excep_correctes\n";
print FILE3 "Excepcions errors=$excep_errors\n";
print FILE3 "Excepcions correctes (nou)=$excep_correctes_new\n";
print FILE3 "Excepcions errors (nou)=$excep_errors_new\n";
print FILE3 "Comuns=$comuns\n";
print FILE3 "Comuns correctes=$comuns_correctes\n";
print FILE3 "Comuns errors=$comuns_errors\n";

close (FILE1);
close (FILE2);

print STDERR "Tests done\n";

#	$word =~ s/é/ê/;
#	$hword = $hyp->visualize($word);
#	$hword =~ s/ê/é/;
#	$hword =~ s/\·//;
#	$hword =~ s/--/-/;
#	$hword =~ s/-/_/g;


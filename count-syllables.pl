# Divideix una única paraula catalana en síl·labes i compta el nombre síl·labes. 
# Paraula d'entrada en UTF-8.
#
# Exemple: `perl count-syllables.pl Shakespeare`
# Resultat: shake-speare: 2 síl·labes

use TeX::Hyphen;
use Encode;

my $newhyp = new TeX::Hyphen 'file' => "hyph-ca-new.tex", 'style' => 'czech', leftmin => 1, rightmin => 1;
my $word = lc $ARGV[0];
Encode::from_to($word, "utf8", "iso-8859-1");
$hcword = $newhyp->visualize($word);
Encode::from_to($hcword, "iso-8859-1", "utf8");
$hcword =~ s/·//g;
$hcword =~ s/--/-/g;
my $count = ($hcword =~ tr/-//) + 1;
print "$hcword: $count síl·labes\n";
#!/bin/bash
perl make-test.pl <mots.txt > mots-separats.txt
perl oneruleperline.pl hyph-ca-new.tex hyph-ca-new2.tex
echo "******** RESULTS ********"
cat resum-resultats.txt
echo "*************************"
echo "Converting patterns..."
perl substrings.pl hyph-ca-new2.tex output.dic ISO-8859-1 1 1 > substrings-results.txt
echo "Done."

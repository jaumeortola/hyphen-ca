#!/bin/bash
perl make-test.pl "hyph-ca-simple.tex" "hyph-ca-new.tex" <mots.txt > mots-separats.txt
echo "******** RESULTS ********"
cat resum-resultats.txt
echo "*************************"
if [[ $1 == release ]]
then
    echo "Converting patterns..."
    perl oneruleperline.pl hyph-ca-new.tex hyph-ca-new2.tex
    perl substrings.pl hyph-ca-new2.tex output.dic UTF-8 > substrings-results.txt
    #Converteix a final de línia Linux
    sed -i 's/$/\r/' output.dic
    #Afegeix la capçalera
    (cat hyph_ca_ES-header.dic ; tail --lines=+2 output.dic) > hyph_ca_ES.dic
    #Elimina fitxers intermedis
    rm hyph-ca-new2.tex
    rm output.dic
    cp hyph_ca_ES.dic office/hyph_ca_ANY.dic
    cd office
    zip -r hyph-ca *
    mv hyph-ca.zip ../results/hyph-ca.oxt
    cd ..
    mv hyph_ca_ES.dic results/hyph_ca_ES.dic

    perl patterns-to-js.pl
    #sed -i 's/ *$//' ca.js

    echo "Done. Output: results/hyph_ca_ES.dic"
fi

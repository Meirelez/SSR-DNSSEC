#!/bin/bash

KEY_ZONE=example.edu
DESIRED_KEYTAG=34345

while true; do

    for i in {1..200}; do

        #KEYTAG=$(dnssec-keygen -a ECDSAP384SHA384 -b 1024  ${KEY_ZONE} | cut -f3 -d'+')
        KEYTAG=$(dnssec-keygen -a ECDSAP256SHA256 -b 1024  ${KEY_ZONE} | cut -f3 -d'+')
        if [[ $KEYTAG = *${DESIRED_KEYTAG}* ]]; then
            echo "Key with desired tag has been generated."
            exit
        fi

        #Keep a log of which key tags we've seen
        echo $KEYTAG >> keytags.txt

    done

    #Clean up and relax
    rm -f *.key *.private
    sleep 7

done

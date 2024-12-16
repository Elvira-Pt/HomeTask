#!bin/bash

# Changes some extensions of files #

if [[ $2 == ".txt" || $2 == ".pdf" || $2 == ".doc" ]]; then
    mv $1 "${1%$2}"$3
else
    echo "Error. Supported extensions are: pdf, doc, txt"
fi

#!bin/bash

# Counts number of args and returns error if it's not 3 #

if [[ ${#@} -eq 3 ]]; then
    echo "Processing..."
else
    echo "Error. Wrong args number"
fi

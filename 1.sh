#!/bin/bash

# Outputs input in lower or upper case #

if [[ $1 == '-u' ]]; then
  echo ${2^^}
elif [[ $1 == '-l' ]]; then
  echo ${2,,}
else
  echo Error. Not supported option $1
fi

#!bin/bash

#builds 'house'

mkdir house
mkdir house/1st_floor
mkdir house/2nd_floor

#1st floor

f1="house/1st_floor/"
mkdir $f1"kitchen"
mkdir $f1"kitchen/fridge"
mkdir $f1"livingroom"
mkdir $f1"closet"

fridge=$f1"kitchen/fridge/"
touch $fridge"goods"
echo "101 apple, 3 breads, 8 eggs, 1 meat" > $fridge"goods"

#2nd floor

f2="house/2nd_floor/"
mkdir $f2"bedroom_for_parents"
mkdir $f2"bedroom_for_kids"
mkdir $f2"bedroom_for_granny"

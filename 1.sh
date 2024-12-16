#!/bin/bash

mkdir -p results
if [ $? -eq 0 ]; then
 echo "Directory results created successfully."
else
 echo "Error creating directory /results."
fi

file="data/gencode.v41.basic.annotation.gff3"
awk -F'\t' '$3 ~ /gene/ {print}' "$file" > filtered_file.gff3

if [ $? -eq 0 ]; then
 echo "Only gene remains."
else
 echo "Error allocating rows with value gene. You should check that the gencode.v41.basic.annotation.gff3 file is in the data/ folder."
fi

awk -F'\t' '$9 ~ /gene_type=unprocessed_pseudogene/ {print}' filtered_file.gff3 > temp.gff3 && mv temp.gff3 filtered_file.gff3

if [ $? -eq 0 ]; then
 echo "Only unprocessed_pseudogene remains."
else
 echo "Error allocating rows with value gene_type=unprocessed_pseudogene."
fi

cut -f 1,4,5,7,9 -d $'\t' filtered_file.gff3 > temp.gff3 && mv temp.gff3 filtered_file.gff3

if [ $? -eq 0 ]; then
 echo "All that remains is the chromosome number, the start coordinate, the end coordinate, the chain direction and the gene description."
else
 echo "Error selecting columns."
fi

sed 's/.*;gene_name=\([^;]*\);.*/\1/' filtered_file.gff3 > output.gff3
awk 'BEGIN { FS = OFS = "\t" } { getline gene_name < "output.gff3"; print $0, "gene_name=" gene_name; }' filtered_file.gff3 > new_input.gff3 && mv new_input.gff3 filtered_file.gff3
cut -f1-4,6- filtered_file.gff3 > temp.gff3 && mv temp.gff3 filtered_file.gff3
rm output.gff3

if [ $? -eq 0 ]; then
 echo "In the gene description column, only its name remains."
else
 echo "Error allocating rows with value gene_name."
fi

awk 'BEGIN { FS = OFS = "\t" } { if ($4 == "+") { $3 = $3 + 1 } print }' filtered_file.gff3 > temp.gff3 && mv temp.gff3 filtered_file.gff3

awk 'BEGIN { FS = OFS = "\t" } { if ($4 == "-") { temp = $2; $2 = $3; $3 = temp; $4 = "+"; $3 = $3 + 1 } print }' filtered_file.gff3 > result.tsv

if [ $? -eq 0 ]; then
 echo "Changing the chain direction and correcting the right boundaries."
else
 echo "Error in chain direction."
fi

rm filtered_file.gff3
mv result.tsv results/

if [ $? -eq 0 ]; then
 echo "The file is saved under the name result.tsv in the result/ folder."
else
 echo "Error in saving file."
fi

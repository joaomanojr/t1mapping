#!/bin/bash

all_year_hits=0

all_acm_hits=0
all_ieee_hits=0
all_wile_hits=0
all_scid_hits=0
all_scop_hits=0
all_spri_hits=0

for year in title_abstract_keywords
do
	year_hits=0
	printf "dir: %s\n" $year
	printf -- "----------------------------------------\n"
	cd $year

	# account ACM hits
	acm_hits=$(grep -Irn "author =" acm* | wc -l)
	printf "ACM hits: %d\n" $acm_hits

	# account IEEE hits
	ieee_hits=$(grep -Irn "TY  -" IEE* | wc -l)
	printf "IEEE hits: %d\n" $ieee_hits

	# account ScienceDirect hits
	scid_hits=$(grep -Irn "TY  -" Sci* | wc -l)
	printf "ScienceDirect hits: %d\n" $scid_hits

	# account scopus hits
	scop_hits=$(grep -Irn "TY  -" scopus* | wc -l)
	printf "Scopus hits: %d\n" $scop_hits

	# account springer hits
	spri_hits=$(grep -Irn "author =" SearchR* | wc -l)
	printf "Springer hits: %d\n" $spri_hits

	# account Wiley hits
	wile_hits=$(grep -Irn "TY  -" per* | wc -l)
	printf "Wiley hits: %d\n" $wile_hits

	for base in acm_hits ieee_hits scid_hits scop_hits spri_hits wile_hits
	do
		year_hits=$(($year_hits + $base))

		declare -n all_var="all_$base"
		all_var=$(($all_var + $base))	
	done

	printf -- "----------------------------------------\n"
	printf "Total %s hits: %d\n" $year $year_hits
	printf -- "----------------------------------------\n\n"
	all_year_hits=$(($all_year_hits + $year_hits))
	cd ..
done


# Are all .ris from Mendeley now

all_base_hits=0

printf "Filtered bases\n" $all_year_hits
printf -- "----------------------------------------\n"

for base in ACM Arxiv Jair IEEE ScienceDirect Scopus Springer Wiley
do
	# account $base hits
	cd ${base}
	base_hits=$(grep -Irn "TY  -" ${base}.ris | wc -l)
	printf "%s hits: %d\n" $base $base_hits
	cd ..

	all_base_hits=$(($all_base_hits + $base_hits))
done

printf -- "----------------------------------------\n"
printf "Total hits: %d\n" $all_base_hits
printf -- "----------------------------------------\n\n"


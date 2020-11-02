#!/bin/bash

all_year_hits=0

all_acm_hits=0
all_ieee_hits=0
all_wile_hits=0
all_scid_hits=0
all_scop_hits=0
all_spri_hits=0

for year in 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020
do
	year_hits=0
	printf "Year: %s\n" $year
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

printf "Totals\n" $all_year_hits
printf -- "----------------------------------------\n"
printf "Total ACM hits: %d\n" $all_acm_hits
printf "Total IEEE hits: %d\n" $all_ieee_hits
printf "Total ScienceDirect hits: %d\n" $all_scid_hits
printf "Total Scopus hits: %d\n" $all_scop_hits
printf "Total Springer hits: %d\n" $all_spri_hits
printf "Total Wiley hits: %d\n" $all_wile_hits
printf -- "----------------------------------------\n"
printf "Total all year hits: %d\n" $all_year_hits


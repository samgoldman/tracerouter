#!/bin/bash

while true; do
	echo --- BEGIN TRACEROUTE SERIES ---
	while read site; do
		echo SITE: $site
		echo TIMESTAMP: $(date +%s) >> $site.txt
		echo TIMESTAMP: $(date +%s) >> $site.location.txt
		termux-location >> $site.location.txt &
		traceroute $site >> $site.txt &
		sleep 1
	done < sites.lst
	echo --- END TRACEROUTE SERIES ---
	echo
	sleep 30;
done

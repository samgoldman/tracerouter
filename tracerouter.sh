#!/bin/bash

# Prevent deep-sleep
termux-wake-lock

while true; do
	echo --- BATTERY CHECK ---
	battery="$(termux-battery-status | jq -r '.percentage')"
	echo TIMESTAMP: $(date +%s) >> battery.status.txt
	echo $battery >> battery.status.txt
	if [$battery -lt 30]
	then
		termux-volume music 100
		termxu-tts-speak Warning! Battery Low!
		termux-volume music 30
	fi
	
	echo --- BEGIN TRACEROUTE SERIES ---
	while read site; do
		echo SITE: $site
		timestamp="$(date +%s)"
		echo TIMESTAMP: $timestamp >> $site.txt
		echo TIMESTAMP: $timestamp >> $site.location.txt
		echo TIMESTAMP: $timestamp >> $site.cellinfo.txt
		termux-location >> $site.location.txt &
		termux-telephony-cellinfo >> $site.cellinfo.txt
		traceroute $site >> $site.txt &
		sleep 1
	done < sites.lst
	echo --- END TRACEROUTE SERIES ---
	echo
	sleep 30;
done

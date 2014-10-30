#!/bin/bash

for virtual in $(virsh -q list)
do
	echo $virtual | egrep -q ".+-.+-.+-.+"
	case $? in
	0)
		echo -n -e "$MY_VM_SERVER\t"
		echo -n -e "$(echo $virtual | awk -F"-" '{print $3}' | tr [A-Z] [a-z])\t\t"
		echo -n -e "unknown\t"
		echo -n -e "$(echo $virtual | awk -F"-" '{print $4}' | tr [A-Z] [a-z])\t"
		echo -n -e "unknown\n"
		;;
	*)	
		;;
	esac
done

exit 0

#!/bin/bash

for domain in $(virsh list)
do
	echo $domain | egrep -q -i "${MY_HOSTNAME}-${MY_ENV}"
	case $? in
	0)
		echo "${MY_HOSTNAME}-${MY_ENV} is running"
		exit 0
		;;
	esac
done

echo "${MY_HOSTNAME}-${MY_ENV} is NOT running"

exit 1

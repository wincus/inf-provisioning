#!/bin/bash

for domain in $(virsh list --all)
do
	echo $domain | egrep -q -i "${MY_HOSTNAME}-${MY_ENV}"
	case $? in
	0)
		virsh reboot $domain
		;;
	esac
done


exit 0

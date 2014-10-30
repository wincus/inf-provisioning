#!/bin/bash

for domain in $(virsh list --all)
do
	echo $domain | egrep -q -i "${MY_HOSTNAME}-${MY_ENV}"
	case $? in
	0)
		virt-viewer --connect ${VIRSH_DEFAULT_CONNECT_URI} $domain &
		sleep 1
		;;
	esac
done


exit 0

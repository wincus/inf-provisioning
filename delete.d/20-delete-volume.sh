#!/bin/bash

while read disk
do
	echo "$disk" | egrep -q -i ${MY_HOSTNAME}-${MY_ENV}
	case $? in
	0)
		DISK_PATH=$(echo $disk | awk '{print $2}')
		virsh vol-delete ${DISK_PATH}
		;;
	esac
done < <(virsh vol-list default)

exit 0

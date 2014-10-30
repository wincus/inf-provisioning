#!/bin/bash

if [ "x$MY_VM_NAME" = "x" ]; then
        echo "Uso: $(basename $0) vm-name"
        exit 1
fi

virsh list --all | egrep -q -i "${MY_HOSTNAME}-${MY_ENV}"  &> /dev/null

case $? in
0)
	echo "$(basename $0): El dominio ${MY_VM_NAME} ya existe"
	exit 1
	;;
esac


exit 0

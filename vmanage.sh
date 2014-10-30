#!/bin/bash

if [ $# -ne 1 -o "x$1" = "x--help" ]; then
	echo "Usage: $(basename $0) $(echo *.d | sed 's/\.d//g' | sed 's/ /|/g')"
	exit 0
else
	export MY_ACTION=$1
fi

export MY_PUPPETMASTER=puppetmaster.domain.org
export MY_REMOTE_USER=username

while read line
do
	echo $line | egrep -q "^#" && continue
	[ -z "$line" ] && continue
	set $line 
	export MY_VM_SERVER=$1
	export MY_HOSTNAME=$2
	export MY_VM_IP=$3
	export MY_ENV=$4
	export MY_VM_RAM=$5
	export MY_COMPUTE_SCRIPT=$6
	export MY_VM_NAME=$(echo AUT-$(date +%Y%m%d)-${MY_HOSTNAME}-${MY_ENV} | tr [a-z] [A-Z])
	export MY_BASE_DISK=$7
	export MY_DISK_SIZE=$8
	
	case $MY_VM_SERVER in
	"server1")
		export VIRSH_DEFAULT_CONNECT_URI="qemu+ssh://${MY_REMOTE_USER}@server1.domain.org/system"
		export MY_COMPUTE_NODE="server1.domain.org"
		;;
    "server2")
		export VIRSH_DEFAULT_CONNECT_URI="qemu+ssh://${MY_REMOTE_USER}@server2.domain.org/system"
		export MY_COMPUTE_NODE="server2.domain.org"
		;;
    "server3")
		export VIRSH_DEFAULT_CONNECT_URI="qemu+ssh://${MY_REMOTE_USER}@server3.domain.org/system"
		export MY_COMPUTE_NODE="server3.domain.org"
		;;
     "server4")
		export VIRSH_DEFAULT_CONNECT_URI="qemu+ssh://${MY_REMOTE_USER}@server4.domain.org/system"
		export MY_COMPUTE_NODE="server4.domain.org"
		;;
	"you get the idea, right?")
		export VIRSH_DEFAULT_CONNECT_URI="qemu+ssh://${MY_REMOTE_USER}@server5.domain.org/system"
		export MY_COMPUTE_NODE="server5.domain.org"
		;;
	*)
		echo "$(basename $0): server unknown: $MY_VM_SERVER"
		continue
		;;
	esac

	for script in ${MY_ACTION}.d/*
	do
                case $script in
                *.sh)
                        [ -x $script ] && $script < /dev/null || continue 2
                        ;;
                *.py)
                        fab -f ${script} all < /dev/null
                        ;;
                esac
        done
done

exit 0

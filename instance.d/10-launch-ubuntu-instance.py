#!/usr/bin/python

from fabric.api import run,env,local,cd,put,sudo
from fabric.context_managers import settings
from xml.etree import ElementTree
import os
import sys

hostname   = os.getenv("MY_HOSTNAME")
vmname     = os.getenv("MY_VM_NAME")
vmmemory   = os.getenv("MY_VM_RAM")
puppetenv  = os.getenv("MY_ENV")
remoteuser = os.getenv("MY_REMOTE_USER")
compute    = os.getenv("MY_COMPUTE_NODE")
script	   = os.getenv("MY_COMPUTE_SCRIPT")
basedisk   = os.getenv("MY_BASE_DISK")
disksize   = os.getenv("MY_DISK_SIZE")

env.hosts = ["%s@%s" % (remoteuser, compute)]

def sanity():
	if not script:
		sys.exit(1)

def cleanleases():
	sudo("service dnsmasq stop")
	sudo("rm -rf /var/lib/misc/dnsmasq.leases")
	sudo("service dnsmasq start")

def launch():
	sudo("sudo /usr/local/sbin/%s %s %s %s %s %s %s" % (script, hostname, compute, puppetenv,vmmemory,basedisk,disksize))

def all():
	sanity()
	cleanleases()
	launch()

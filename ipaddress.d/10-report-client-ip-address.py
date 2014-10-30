#!/usr/bin/python

from fabric.api import run,env,local,cd,put,sudo
from fabric.context_managers import settings
import os

hostname   = os.getenv("MY_HOSTNAME")
faiserver  = os.getenv("MY_FAI_SERVER")
vmname     = os.getenv("MY_VM_NAME")
ipaddress  = os.getenv("MY_VM_IP")
puppetenv  = os.getenv("MY_ENV")
puppetmas  = os.getenv("MY_PUPPETMASTER")
vmserver   = os.getenv("MY_VM_SERVER")
remoteuser = os.getenv("MY_REMOTE_USER")

env.hosts = ["%s@%s" % (remoteuser,puppetmas)]
env.warn_only = True

def reportipaddress():
        with cd("/var/lib/puppet/yaml/facts"):
            sudo("egrep eth0 %s" % hostname + "." + puppetenv + "." + vmserver + ".domain.org.yaml")

def all():
    reportipaddress()
	

#!/usr/bin/python

from fabric.api import run,env,local,cd,put,sudo
from fabric.context_managers import settings
from xml.etree import ElementTree
import os

hostname   = os.getenv("MY_HOSTNAME")
vmname     = os.getenv("MY_VM_NAME")
ipaddress  = os.getenv("MY_VM_IP")
vmserver   = os.getenv("MY_VM_SERVER")
remoteuser = os.getenv("MY_REMOTE_USER")
puppetmas  = os.getenv("MY_PUPPETMASTER")
puppetenv  = os.getenv("MY_ENV")

env.hosts = ["%s@%s" % (remoteuser,puppetmas)]
env.warn_only = True                                                                                                                                                                                        

def clean_client_certs():
	run("sudo salt-key -y --delete %s" % hostname + "." + puppetenv + "." + vmserver + ".domain.org")

def all():
	clean_client_certs()

#!/usr/bin/python

from fabric.api import run,env,local,cd,put,sudo
from fabric.context_managers import settings
from xml.etree import ElementTree
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

def clean_client_certs():
	run("sudo puppet cert clean %s" % hostname + "." + puppetenv + "." + vmserver + ".domain.org")

def clean_from_dashboard():
	with cd("/usr/share/puppet-dashboard"):
		sudo("rake RAILS_ENV=production node:del name=%s" % hostname + "." + puppetenv + "." + vmserver + ".domain.org")

def clean_client_facts():
        with cd("/var/lib/puppet/yaml/facts"):
                sudo("rm -rf %s" % hostname + "." + puppetenv + "." + vmserver + ".domain.org.yaml") 

def all():
	clean_client_certs()
	clean_from_dashboard()
        clean_client_facts()

#!/usr/local/bin/python

from netaddr import *
net = IPNetwork('10.10.0.0/16')
for ip in net.subnet(24):
  print 'route '+str(ip)+' unreachable'

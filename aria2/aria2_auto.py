##!/usr/bin/env python
import urllib2, json, time

WEEKDAY = int(time.strftime('%w'))
HOUR = int(time.strftime('%H'))
jsonreq_pauseAll   = json.dumps({'jsonrpc':'2.0', 'id':'qwer','method':'aria2.pauseAll'})
jsonreq_unpauseAll = json.dumps({'jsonrpc':'2.0', 'id':'qwer','method':'aria2.unpauseAll'})

if WEEKDAY in [1,2,3,4,5,6,0]:
  if HOUR == 3: 
    urllib2.urlopen('http://localhost:6800/jsonrpc', jsonreq_unpauseAll)

if HOUR == 18:
    urllib2.urlopen('http://localhost:6800/jsonrpc', jsonreq_pauseAll)

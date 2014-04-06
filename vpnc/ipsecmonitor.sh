#!/bin/sh
# vpnc and route monitor

while true
do
#  /usr/bin/systemctl status vpnc.service
#  VPNCStatus=$?
  VPNCStatus=$(/usr/bin/pidof vpnc | wc -w)
  if [ $VPNCStatus -eq 0 ]
  then
    /usr/bin/systemctl start vpnc.service
    VPNCStatus=$(/usr/bin/pidof vpnc | wc -w)
    if [ $VPNCStatus -ne 0 ]
    then
      /bin/sh /etc/vpnc/vpnup.sh
    fi
  fi
  sleep 10
done


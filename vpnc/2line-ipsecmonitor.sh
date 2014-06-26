#!/bin/sh
# vpnc and route monitor

while true
do
## check vpnc
  VPNCStatus=$(ps -ef | grep "/usr/bin/vpnc$" | grep -v grep | wc -l)
  if [ $VPNCStatus -eq 0 ]
  then
    /usr/bin/systemctl start vpnc.service
    VPNCStatus=$(/usr/bin/pidof vpnc | wc -w)
    if [ $VPNCStatus -ne 0 ]
    then
      /bin/sh /etc/vpnc/vpnup.sh
    fi
  fi

## check vpnchk
  VPNCHKStatus=$(/usr/bin/pidof vpnchk | wc -w)
  if [ $VPNCHKStatus -eq 0 ]
  then
    /usr/bin/systemctl start vpnchk.service
    VPNCHKStatus=$(/usr/bin/pidof vpnchk | wc -w)
    if [ $VPNCHKStatus -ne 0 ]
    then
      if [ $VPNCStatus -ne 0 ]
      then
        /usr/bin/route add default dev tun0
      fi  
      /usr/bin/route del default dev tun1
      ## add route for TVB Limited
      /usr/bin/route add -net 202.126.48.0/20 dev tun1
      #/usr/bin/route add -net 202.126.47.0/24 dev tun1
      #/usr/bin/route add -net 202.126.48.0/24 dev tun1
    fi
  fi

  sleep 8
done

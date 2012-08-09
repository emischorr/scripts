#!/bin/sh
# This change will no longer be in effect after rebooting

# run this script as root
if [[ $EUID -ne 0 ]] ; then
  echo >&2  "You need to be root to execute this script!"
  exit 1
fi

if ([ "$1" ] && [ "$2" ]) ; then
  /sbin/ifconfig $1:0 $2
  /sbin/route add -host $2 dev $1:0
  exit 0
else
  echo >&2 "Usage: "$(basename "$0")" <interface> <ip>"
  exit 1
fi

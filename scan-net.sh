#!/bin/sh
if [ "$1" ] ; then
  nmap -sP $1 | grep report | awk '{print $5" "$6}'
else
  echo >&2 "Using default net: 192.168.178.1/24"
  nmap -sP 192.168.178.1/24 | grep report | awk '{print $5" "$6}'
fi

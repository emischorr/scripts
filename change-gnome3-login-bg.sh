#!/bin/sh

# run this script as root

if [[ $EUID -ne 0 ]] ; then
  echo >&2  "You need to be root to execute this script!"
  exit 1
fi

if [ "$1" ] ; then
  path=`readlink-f "$1"`
  if [ -e "$path" ] ; then
    # Export dconf session variables
    dconf_session_cmd='`dbus-launch | sed "s/^/export /"`'

    # Workaround for XDG_RUNTIME_DIR (not set when switching user with 'su -')
    xdg_cmd='XDG_RUNTIME_DIR=/run/user/gdm'

    # TODO: check for dconf-service and if not, start it
    #ps aux | grep dconf
    #/usr/libexec/dconf-service &

    # Set background image
    set_bg_cmd="GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri 'file://$1'"

    cmd="$dconf_session_cmd; $xdg_cmd; $set_bg_cmd"

    # Change user to gdm and execute cmd
    su - gdm -s /bin/bash -c "$cmd"

    exit 0
  else
    echo >&2 "No such file in path: $path"
    exit 1
  fi
else
  echo >&2 "Usage: "$(basename "$0")" PATH_TO_PICTURE"
  exit 1
fi

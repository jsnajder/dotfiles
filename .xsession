#!/bin/bash
 
# Load resources
 
xrdb -merge .Xresources
 
# Set up an icon tray
 
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x000000 --height 15 &
 
# Set the background color
 
xsetroot -solid black

# HR key bindings on top of US layout

xmodmap ~/.Xmodmap
 
# Fire up apps
 
xscreensaver -no-splash &
 
if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi
 
if [ -x /usr/bin/gnome-power-manager ] ; then
   sleep 3
   gnome-power-manager &
fi

if [ -x /usr/bin/hamster-indicator ] ; then
   hamster-indicator &
fi

if [ -x /usr/bin/dropbox ] ; then
   dropbox start &
fi

#started twice, becase of an error in zim
if [ -x /usr/bin/zim ] ; then
   zim &
   zim &
fi

if [ -x /usr/local/bin/junglediskdesktop ] ; then
  junglediskdesktop --standalone &
fi

if [ -x /opt/extras.ubuntu.com/calendar-indicator/bin/calendar-indicator ] ; then
  /opt/extras.ubuntu.com/calendar-indicator/bin/calendar-indicator &
fi

exec xmonad

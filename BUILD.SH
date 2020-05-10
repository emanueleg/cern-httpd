#!/bin/sh
#			Build all WWW Code for this platform
#
#	Figure out what sort of unix this is
#	(NeXT machines don't have uname!)

# When BUILDing a SOCKSified httpd:
# Set this to the location of your ready-built SOCKS library
# setenv SOCKSLIB /xxxx/yyyy/libsocks.a

## Use this setting to enable SOCKS:
# setenv SOCKS_FLAGS -DSOCKS
## ..OR this setting to enable both SOCKS _and_ client access control:
# setenv SOCKS_FLAGS "-DSOCKS -DCLIENT_CONTROL"
## Note that cern_httpd's normal access control can be used instead.

UNAME=""
if [ -s /usr/bin/uname ]; then		UNAME=`/usr/bin/uname`; fi
if [ -s /bin/uname ]; then 		UNAME=`/bin/uname`; fi
#
export UNAME

if [ "$UNAME" = "Linux" ]; then		WWW_MACH=linux;export WWW_MACH;fi

if [ "$WWW_MACH" = "" ]; then
	echo
	echo "Please edit BUILD file to include your machine OS"
	echo "and mail differences back to www-bug@info.cern.ch"
	echo
	exit -99
fi
echo "________________________________________________________________"
echo "WWW build for machine type:                            " $WWW_MACH

#	Now go do build

#	We don't want SHELL set to something funny to screw up make

(cd All/Implementation; unset SHELL; make)
stat=$?
echo
echo "WWW build for " $WWW_MACH  " done. status = " $stat
exit $stat

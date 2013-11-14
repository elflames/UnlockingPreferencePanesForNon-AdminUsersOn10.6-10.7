#!/bin/bash
####################################################################################################
#
# More information: http://macmule.com/2012/05/13/unlocking-preference-panes-for-non-admin-users-on-10-6-10-7/
#
# GitRepo: https://github.com/macmule/UnlockingPreferencePanesForNon-AdminUsersOn10.6-10.7/
#
# License: http://macmule.com/license/
#
###################################################################################################

#Backup the original authorization file
sudo /bin/cp /etc/authorization /etc/authorization.original.backup

#Get OS version
OS=`/usr/bin/defaults read /System/Library/CoreServices/SystemVersion ProductVersion | awk '{print substr($1,1,4)}'`

#If OS is 10.6...
if [[ "$OS" == "10.6" ]]; then
	#Modify /etc/authorization to allow any member of the everyone group access to unlock preferences
	sudo /usr/libexec/PlistBuddy -c "Set :rights:system.preferences:group everyone" /etc/authorization
	sudo /usr/libexec/PlistBuddy -c "Set :rights:system.preferences:shared true" /etc/authorization
	echo "Given rights to the everyone group to unlock secure system preferences for OS $OS..."
else
	# Unlock System Preferences for non admins.
	sudo /usr/libexec/PlistBuddy -c 'Set :rights:system.preferences:group everyone' /etc/authorization
	# Unlock Accessibiltity preference pane
	sudo /usr/libexec/PlistBuddy -c 'Set :rights:system.preferences.accessibility:group everyone' /etc/authorization
	# Unlock Date and Time
	sudo /usr/libexec/PlistBuddy -c 'Set :rights:system.preferences.datetime:group everyone' /etc/authorization
	# Unlock Energy Saver preference pane
	sudo /usr/libexec/PlistBuddy -c 'Set :rights:system.preferences.energysaver:group everyone' /etc/authorization
	# Unlock Network Settings preference pane
	sudo /usr/libexec/PlistBuddy -c 'Set :rights:system.preferences.network:group everyone' /etc/authorization
	# Unlock Print & Scan Preference pane
	sudo /usr/libexec/PlistBuddy -c 'Set :rights:system.preferences.printing:group everyone' /etc/authorization
	# Unlock Startup Disk Preference pane
	sudo /usr/libexec/PlistBuddy -c 'Set :rights:system.preferences.startupdisk:group everyone' /etc/authorization
	# Unlock Time Machine preference pane
	sudo /usr/libexec/PlistBuddy -c 'Set :rights:system.preferences.timemachine:group everyone' /etc/authorization
	echo "Given rights to the everyone group to unlock secure system preferences for OS $OS..."
fi

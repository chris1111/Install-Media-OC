# Applescript create by chris1111
# Install Media OC.app Copyright (c) 2020, 2023 chris1111 All rights reserved.
# No right on OpenCore Bootloader

set theAction to button returned of (display dialog "
Welcome Install Media OC
You can create a bootable USB key 
of macOS Catalina 10.15 to macOS Ventura 13
" with icon note buttons {"Quit", "OC Installer", "USB Creation"} cancel button "Quit" default button {"USB Creation"})
if theAction = "OC Installer" then
	set source to path to me as string
	set source to POSIX path of source & "Contents/Resources/Installer/OpenCoreUSB.pkg"
	set source to quoted form of source
	do shell script "open " & source & "/"
end if

--If Create Install Media
if theAction = "USB Creation" then
	display dialog "Format your USB Drive with Disk Utility 
in the format Mac OS Extended (Journaled) 
GUID Partition Map

*****************************
You must quit Disk Utility to continue 
installation !" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
	do shell script "open -F -a 'Disk Utility'"
	delay 1
	tell application "Disk Utility"
		activate
	end tell
	
	repeat
		if application "Disk Utility" is not running then exit repeat
		
	end repeat
	
	activate me
	set all to paragraphs of (do shell script "ls /Volumes")
	set w to choose from list all with prompt " 
Select the Drive you have just formatted.

Then press the OK button" OK button name "OK" with multiple selections allowed
	if w is false then
		display dialog "Quit Installer " with icon note buttons {"EXIT"} default button {"EXIT"}
		
		return
	end if
	try
		repeat with teil in w
			do shell script "diskutil `diskutil list | awk '/ " & teil & "  / {print $NF}'`" with administrator privileges
		end repeat
	end try
	
	set theName to "USB-MEDIA"
	tell application "Finder"
		set name of disk w to theName
		
	end tell
	--If Continue	
	display dialog "Choose the location of your Install macOS.app" with icon note buttons {"Quit", "Install macOS"} cancel button "Quit" default button {"Install macOS"}
	
	set InstallOSX to choose file of type {"XLSX", "APPL"} default location (path to applications folder) with prompt "Choose your Install macOS.app"
	set OSXInstaller to POSIX path of InstallOSX
	
	delay 2
	
	set progress description to "Install Media OC
======================================
Installation time 15 to 25 min on a standard USB key
5 min to an External USB Drive
======================================
"
	
	set progress total steps to 8
	
	set progress additional description to "Analysing Install macOS 10%"
	delay 2
	set progress completed steps to 1
	
	set progress additional description to "Analysing USB Install Media 20%"
	delay 2
	set progress completed steps to 2
	
	set progress additional description to "Install USB Media OK 30%"
	delay 2
	set progress completed steps to 3
	
	set progress additional description to "Install in Progress 40%"
	delay 1
	set progress completed steps to 4
	
	set progress additional description to "Install in Progress 50%"
	delay 1
	set progress completed steps to 5
	
	set progress additional description to "
Installation on Volumes ➤ USB-MEDIA . . 60% 
Wait! . . . . ."
	delay 1
	
	--display dialog cmd
	set cmd to "sudo \"" & OSXInstaller & "Contents/Resources/createinstallmedia\" --volume /Volumes/USB-MEDIA --nointeraction "
	do shell script cmd with administrator privileges
	set progress completed steps to 6
	delay 2
	
	set progress additional description to "Install Media 80%"
	delay 2
	
	set progress additional description to "Install Media 90%"
	delay 2
	set progress completed steps to 7
	set progress additional description to "
Install Media OC ➤ 100%
Open OpenCore Installer! "
	delay 3
	set source to path to me as string
	set source to POSIX path of source & "Contents/Resources/Installer/OpenCoreUSB.pkg"
	set source to quoted form of source
	do shell script "open " & source & "/"
end if

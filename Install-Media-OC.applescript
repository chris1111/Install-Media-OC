# Applescript create by chris1111
# Copyright (c) 2020, 2025 chris1111 All rights reserved.
# No right on OpenCore Bootloader
#
# Credit: Apple
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# Version "1.0" by chris1111
# Vars

set theAction to button returned of (display dialog "
Welcome to Install Media OC
You can create a bootable USB drive
from macOS High Sierra 10.13 to macOS Tahoe 26.

To create a USB installation media, you need a 16 GB or larger USB drive.

Starting with macOS Sonoma 14, some 16 GB USB drives are not sufficient, so use a 32 GB USB drive to avoid errors.

NOTE: SIP security and Gatekeeper must be disabled." with icon note buttons {"Quit", "OC-Installer", "Create Install Media"} cancel button "Quit" default button {"Create Install Media"})

if theAction = "OC-Installer" then
	set source to path to me as string
	set source to POSIX path of source & "Contents/Resources/Installer/OpenCoreUSB.pkg"
	set source to quoted form of source
	do shell script "open " & source & "/"
end if

--If Create Install Media
if theAction = "Create Install Media" then
	
	tell application "Disk Utility"
		activate
	end tell
	
	repeat
		if application "Disk Utility" is not running then exit repeat
	end repeat
	activate me
	set Volumepath to paragraphs of (do shell script "ls /Volumes")
	set Diskpath to choose from list Volumepath with prompt "
To be able to continue, select the volume
that you just formatted.
Then press the OK button" OK button name "OK" with multiple selections allowed
	if Diskpath is false then
		display dialog "Quit Installer " with icon 0 buttons {"EXIT"} default button {"EXIT"}
		return
		
		return (POSIX path of Diskpath)
	end if
	try
		--If Continue		
		set theAction to button returned of (display dialog "

Choose the location of your Install macOS.app" with icon note buttons {"Quit", "macOS 10.12", "10.13 to Tahoe 26"} cancel button "Quit" default button {"10.13 to Tahoe 26"})
		if theAction = "10.13 to Tahoe 26" then
			--If 10.13 to Tahoe 26
			display dialog "
Your choice is 10.13 to Tahoe 26
Choose your Install OS X.app 
From macOS High Sierra to macOS Tahoe" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
			
			set InstallOSX to choose file of type {"XLSX", "APPL"} default location (path to applications folder) with prompt "Choose your Install macOS.app"
			set OSXInstaller to POSIX path of InstallOSX
			
			delay 2
			(display dialog "Please confirm your choice?
Create Install Media from --> " & (InstallOSX as text) & "
Install to --> " & (Diskpath as text) with icon note buttons {"Cancel", "OK"} cancel button "Cancel" default button "OK")
			
			set progress description to "Create Install Media
======================================
Installation time 15 to 25 min on a standard USB key
3 to 5 min on a Disk Ext HD
======================================
"
			
			set progress total steps to 7
			
			set progress additional description to "Analysing Install macOS"
			delay 2
			set progress completed steps to 1
			
			set progress additional description to "Analysing USB Install Media"
			delay 2
			set progress completed steps to 2
			
			set progress additional description to "Install USB Media OK"
			delay 2
			set progress completed steps to 3
			
			set progress additional description to "Install in Progress "
			delay 1
			set progress completed steps to 4
			
			set progress additional description to "Install in Progress Wait! "
			delay 1
			set progress completed steps to 5
			
			set progress additional description to "Installing macOS  wait . . . ."
			delay 1
			--display dialog cmd
			set cmd to "sudo \"" & OSXInstaller & "Contents/Resources/createinstallmedia\" --volume /Volumes/\"" & Diskpath & "\" --nointeraction"
			do shell script cmd with administrator privileges
			delay 2
			do shell script "rm -rf  /Volumes/'Install macOS'*/.VolumeIcon.icns"
			set progress completed steps to 6
			
			set progress additional description to "Install in Progress 90%"
			delay 2
			set progress completed steps to 7
			set progress additional description to "
			Create Install Media Completed ➤ ➤ ➤ 100%
Create Install Media Completed.
OpenCore Installer! "
			set theFile to ((path to me) as string) & "Contents:Resources:Installer:OpenCoreUSB.pkg"
			tell application "Finder" to open theFile
			
		else if theAction = "macOS 10.12" then
			
			--If 10.9 to 10.12
			display dialog "
macOS 10.12
Choose the location of your Install macOS.app
" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
			
			set InstallOSX to choose file of type {"XLSX", "APPL"} default location (path to applications folder) with prompt "Choose your Install macOS.app"
			set OSXInstaller to POSIX path of InstallOSX
			
			delay 2
			(display dialog "Please confirm your choice?
Create Install Media from --> " & (InstallOSX as text) & "
Install to --> " & (Diskpath as text) with icon note buttons {"Cancel", "OK"} cancel button "Cancel" default button "OK")
			
			
			set progress description to "Create Install Media
======================================
Installation time 15 to 20 min on a standard USB key
3 to 5 min on a Disk Ext HD
======================================
"
			
			set progress total steps to 7
			
			set progress additional description to "Analysing Install macOS"
			delay 2
			set progress completed steps to 1
			
			set progress additional description to "Analysing USB Install Media"
			delay 2
			set progress completed steps to 2
			
			set progress additional description to "Install USB Media OK"
			delay 2
			set progress completed steps to 3
			
			set progress additional description to "Install in Progress "
			delay 1
			set progress completed steps to 4
			
			set progress additional description to "Install in Progress Wait! "
			delay 1
			set progress completed steps to 5
			
			set progress additional description to "Installing macOS  wait . . . ."
			delay 1
			--display dialog cmd
			set cmd to "sudo \"" & OSXInstaller & "Contents/Resources/createinstallmedia\" --volume /Volumes/\"" & Diskpath & "\" --applicationpath \"" & OSXInstaller & "\" --nointeraction"
			do shell script cmd with administrator privileges
			delay 2
			do shell script "rm -rf  /Volumes/'Install macOS'*/.VolumeIcon.icns"
			
			set progress completed steps to 6
			
			set progress additional description to "Install in Progress 90%"
			delay 2
			set progress completed steps to 7
			set progress additional description to "
Create Install Media Completed ➤ ➤ ➤ 100%
Create Install Media Completed.
OpenCore Installer! "
			delay 3
			set theFile to ((path to me) as string) & "Contents:Resources:Installer:OpenCoreUSB.pkg"
			tell application "Finder" to open theFile
		end if
		
	end try
end if

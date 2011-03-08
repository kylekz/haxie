#LevelUnlocker by Ramsey
#Follow @iamramsey on Twitter
#Ramsey is: Isaac Moore
#-------------
#Thanks to:
#MadHouse (for practically teaching me bash)
#rastignac (whose scripts serve as a great Bash 101 lesson)
#dissident (without him, the scene might not even be where it is today)
#WYSE (Testing)
#Kaikz (making an awesome GUI)
#-------------
#Changelog:
#---
#v0.1: Support for one Applications:
#-Cut the Rope
#---
#v0.1.2: Added support for:
#-Cut the Rope Holiday Gift
#---
#v0.1.3: Added support for:
#-Cut the Rope Lite
#---
#v0.2
#Fixed bug
#Added -s flag
#-------------
#v0.3
#Better Support for Kaikz's Haxie
#Outputs a supported app list to /var/mobile/supported_levelunlocker.txt
#-------------
#Coming Soon:
#Astronut
#-------------
#New apps are added with every update.
#Feel free to help out with the effort, at:
#http://hackulo.us/
#-------------
#This script is VERY similar to dlc.sh.
#That's because the idea behind both is almost the same,
#as is the method used to carry them out.

function supported
{
#Had to remove the "- Chillingo " else it'd go over to a new line. -Kaikz

#Cut the Rope
appdir=$(grep -i "CutTheRope.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Cut the Rope"
fi

#Cut the Rope Holiday
appdir=$(grep -i "CutTheRopeGift.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Cut the Rope Holiday Gift"
fi

#Cut the Rope Lite
appdir=$(grep -i "CutTheRopeLite.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Cut the Rope Lite"
fi

#Remove apps list
rm -rf /tmp/App_list.tmp

#Exit
exit 1
}

#All the glitz:
clear
echo "__________________________"
echo "|     LevelUnlocker      |"
echo "|         v0.3.1         |"
echo "|       by Ramsey        |"
echo "|________________________|"
echo " "
echo " "
echo "Loading... "

#We need plutil. Checking for it (and prompting for install)...
if [ ! -e /usr/bin/plutil ]; then
        echo "Erica Utils is not Installed. "
        read -p "Would you like to install it now? [Y/N] " response
        if [ "$response" -eq "Y" ]; then
                clear
                echo "Installing..."
                apt-get install com.ericasadun.utilities
        else
                echo "Please install from Cydia. "      
                exit 1
        fi
fi

#Checking for outdated apps list (and removing)...
if [ -e /tmp/applist ]; then
        rm -rf /tmp/applist
fi

#Creating the apps list...
ls -d /var/mobile/Applications/*/*.app > /tmp/App_list.tmp

#Checking for operation flags...
if [ "$1" = "-s" ]; then #Since I'm too lazy to do it all programmatically. -Kaikz
	supported_loc="/var/mobile/supported_levelunlocker.txt"
	if [ ! -e $supported_loc ]; then
		supported > $supported_loc
                else
        rm $supported_loc
			supported > $supported_loc
fi
fi

#Cut the Rope
#by Ramsey

echo "Looking for Cut the Rope... "
appdir=$(grep -i "CutTheRope.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Unlocking levels..."
        echo "Please wait..."
        for box in {0..5}
        do
                for lvl in {0..24}
                do
                        key="UNLOCKED_${box}_$lvl"
                        cd "$appdir"
                        cd "../Library/Preferences/"
                        plutil -key "$key" -value '1' "com.chillingo.cuttherope.plist" 2>&1> /dev/null
                        done
                done
                echo "Cut the Rope: Unlocked! "
fi

#Cut the Rope Holiday Gift
#by Ramsey

echo "Looking for Cut the Rope Holiday Gift... "
appdir=$(grep -i "CutTheRopeGift.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Unlocking levels..."
        echo "Please wait..."
        for lvl in {0..24}
        do
                key="UNLOCKED_0_$lvl"
                cd "$appdir"
                cd "../Library/Preferences/"
                plutil -key "$key" -value '1' "com.chillingo.cuttheropexmas.plist" 2>&1> /dev/null
        done
        echo "Cut the Rope Holiday Gift: Unlocked! "
fi

#Cut the Rope Lite
#by Ramsey

echo "Looking for Cut the Rope Lite... "
appdir=$(grep -i "CutTheRopeLite.app" /tmp/App_list.tmp)
if [ ! -z "$appdir" ]; then
        echo "Unlocking levels..."
        echo "Please wait..."
        for box in {0..4}
        do
                for lvl in {0..5}
                do
                        key="UNLOCKED_${box}_$lvl"
                        cd "$appdir"
                        cd "../Library/Preferences/"
                        plutil -key "$key" -value '1' "com.chillingo.cuttheropelite.plist" 2>&1> /dev/null
                done
        done
        echo "Cut the Rope Lite: Unlocked! "
fi

echo "Done! "

rm -rf /tmp/App_list.tmp

exit 1
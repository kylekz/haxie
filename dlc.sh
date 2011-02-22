#!/bin/sh
#
Version="dlc.sh - v0.4.7 (2011-02-18)"
#
# Thanks to: Alidsl, C4PDA, Cybot2006, Darksx, Eugénie, Farhanito, Frigis, Goriot, Joker999, Kaikz, Ramsey, Sharmanhall, Sirakain, Tiantou, Ushnak...
#


# # # # #
function SearchApp
{
AppName=$1
AppDir=$2
AppUrl=$3

if [ $listing = 1 ]; then
echo "$AppName" >> "/var/mobile/supported_dlc.txt"
return 0
fi
if [ $listing = 2 ]; then
echo "<li><a href=\"$AppUrl\">$AppName</a>.</li>" >> "/var/mobile/supported_dlc.txt"
return 0
fi

echo -n "- $AppName. "
tempLoc=$(grep -i "$AppDir" /tmp/lsd.tmp)
if [ ! -z "$tempLoc" ]; then
AppCount=$(echo "$tempLoc" | wc -l)
if [ $AppCount -gt 1 ]; then
echo
echo "Found $AppCount installation directories."
return 2
else
echo "OK"
return 1
fi
fi
echo ""
return 0
}


# # # # #
function Success
{
number=$(($number + 1))
if [ -z "$ListApp" ]; then
ListApp="$AppName"
else
ListApp="$ListApp, $AppName"
fi
}


# # # # #
# BEGIN #
# # # # #

# Is it 'root' or 'mobile' ?
#if [ $EUID = 0 ]; then
#       echo "Warning: you should not run as 'root'."
#fi


# # # # #
# Create/refresh list of supported apps ?
listing=0
if [ "$1" = "-txt" ]; then
listing=1
fi
if [ "$1" = "-html" ]; then
listing=2
fi
if [ $listing != 0 ]; then
cat /dev/null > "/var/mobile/supported_dlc.txt"
chmod 666 "/var/mobile/supported_dlc.txt"
else
clear
echo "$Version"
echo
# Plutil is needed
if [ ! -e /usr/bin/plutil ]; then
echo "Cannot find tool 'plutil'. Install Erica Utils from Cydia."
exit 1
fi
echo "Looking for apps:"
# Get and store the whole apps list
rm -f /tmp/lsd.tmp
ls -d /var/mobile/Applications/*/*.app > /tmp/lsd.tmp
number=0
ListApp=""
fi


# # # # #
SearchApp "ArchMageDefense" "WizardDefense.app" "http://appshopper.com/games/archmage-defense"
if [ $? = 1 ]; then
plutil -key 'purchased' -type bool -value 'true' "$tempLoc/../Library/Preferences/cde.WizardDefense.plist" 2>&1> /dev/null
Success
fi

# This one is from Ramsey.
SearchApp "AstroNut" "Astronut.app" "http://appshopper.com/games/astronut"
if [ $? = 1 ]; then
plutil -key 'isUpgradePurchased' -type bool -value 'true' "$tempLoc/../Library/Preferences/com.iconfactory.AstroNut.plist" 2>&1> /dev/null
Success
fi

# This one is from Kaikz.
SearchApp "BattleBears -1" "battlebearsneg1.app" "http://appshopper.com/games/battle-bears-1"
if [ $? = 1 ]; then
plutil -key 'downloadedCampaigns' -value 'net.skyvu.battlebearsneg1.riggs' "$tempLoc/../Library/Preferences/net.skyvu.battlebearsneg1.plist" 2>&1> /dev/null
Success
fi

SearchApp "BattleField/BattleZone" "BattleField.app" "http://appshopper.com/games/battle-field"
if [ $? = 1 ]; then
plutil -key '' -value '1' "$tempLoc/../Documents/upgrade1.plist" 2>&1> /dev/null
Success
fi

SearchApp "Buster Red" "nunix2.app" "http://appshopper.com/games/buster-red"
if [ $? = 1 ]; then
for x in "E" "QU"; do
plutil -key "BR$x" -type bool -value 'true' "$tempLoc/../Library/Preferences/com.iskandarinc.busterred.plist" 2>&1> /dev/null
done
Success
fi

# This one is from Ramsey.
SearchApp "Camera+" "CameraPlus.app" "http://appshopper.com/photography/camera%C2%A0%E2%80%A6the-ultimate-photo-app"
if [ $? = 1 ]; then
for x in "analog" "hollywood"; do
plutil -key "com.taptaptap.CameraPlus.fx.$x" -key 'purchased' -type bool -value 'true' "$tempLoc/../Library/Application Support/products.plist" 2>&1> /dev/null
done
Success
fi

SearchApp "Capcom Arcade" "capcomacUS.app" "http://appshopper.com/games/capcom-arcade"
if [ $? = 1 ]; then
plutil -key 'cheatitem_1942' -value '7' "$tempLoc/../Library/Preferences/CCC.plist" 2>&1> /dev/null
#plutil -key 'cheatitem_1943' -value 'xxx' "$tempLoc/../Library/Preferences/CCC.plist" 2>&1> /dev/null
plutil -key 'cheatitem_daimakai' -value '15' "$tempLoc/../Library/Preferences/CCC.plist" 2>&1> /dev/null
#plutil -key 'cheatitem_ff' -value 'xxx' "$tempLoc/../Library/Preferences/CCC.plist" 2>&1> /dev/null
plutil -key 'cheatitem_ikusa' -value '7' "$tempLoc/../Library/Preferences/CCC.plist" 2>&1> /dev/null
plutil -key 'cheatitem_makai' -value '15' "$tempLoc/../Library/Preferences/CCC.plist" 2>&1> /dev/null
plutil -key 'cheatitem_st2' -value '3' "$tempLoc/../Library/Preferences/CCC.plist" 2>&1> /dev/null
plutil -key 'cheatitem_st2dash' -value '3' "$tempLoc/../Library/Preferences/CCC.plist" 2>&1> /dev/null
plutil -key 'gamebase' -value '255' "$tempLoc/../Library/Preferences/CCC.plist" 2>&1> /dev/null
plutil -key 'ticket' -value '9' "$tempLoc/../Library/Caches/CCC.plist" 2>&1> /dev/null
plutil -key 'token' -value '99' "$tempLoc/../Library/Caches/CCC.plist" 2>&1> /dev/null
Success
fi

# This one is from Kaikz.
SearchApp "ChalkBoardStunts (not Pro)" "Stunts.app" "http://appshopper.com/games/chalkboard-stunts"
if [ $? = 1 ]; then
if [ -e "$tempLoc/../Library/Preferences/com.manta.Stunts.plist" ]; then
plutil -key 'Mobclix' -type bool -value 'false' "$tempLoc/../Library/Preferences/com.manta.Stunts.plist" 2>&1> /dev/null
for x in "carupgrade" "doodle.theme" "levelbuilder" "newNOSupgrade"; do
plutil -key "com.manta.Stunts.$x" -type bool -value 'true' "$tempLoc/../Library/Preferences/com.manta.Stunts.plist" 2>&1> /dev/null
done
Success
else
# Our princess is in another castle
echo "  Sorry, homonym app..."
# (Thanks to Neblinio).
fi
fi

# This one is from Joker999.
SearchApp "ClassicToy" "ClassicTOY.app" "http://appshopper.com/photography/classictoy-plastic-toy-camera"
if [ $? = 1 ]; then
plutil -key 'isPayed' -value '1' "$tempLoc/../Documents/ConfigXML.plist" 2>&1> /dev/null
Success
fi

SearchApp "Cobra Command" "cobracommand.app" "http://appshopper.com/games/cobra-command"
if [ $? = 1 ]; then
if [ ! -e /usr/bin/xxd ]; then
echo "Cannot find tool 'xxd'. Install from Cydia."
else
plutil -key 'optionsData' "$tempLoc/../Library/Preferences/com.collect3.cobracommand.plist" | xxd -r -p > "$tempLoc/../Library/Preferences/optionsData.plist"
plutil -xml "$tempLoc/../Library/Preferences/optionsData.plist" 2>&1> /dev/null
cat "$tempLoc/../Library/Preferences/optionsData.plist" | tr -d '\t','\n' | \
sed -e 's=<key>purchasedAllLevels</key><false/>=<key>purchasedAllLevels</key><true/>=g' \
-e 's=<key>purchasedGodMode</key><false/>=<key>purchasedGodMode</key><true/>=g' \
-e 's=<key>purchasedUnlimitedLives</key><false/>=<key>purchasedUnlimitedLives</key><true/>=g' \
> "$tempLoc/../Library/Preferences/optionsData2.plist"
plutil -binary "$tempLoc/../Library/Preferences/optionsData2.plist" 2>&1> /dev/null
plutil -key 'optionsData' -data "$tempLoc/../Library/Preferences/optionsData2.plist" "$tempLoc/../Library/Preferences/com.collect3.cobracommand.plist" 2>&1> /dev/null
rm "$tempLoc/../Library/Preferences/optionsData2.plist"
rm "$tempLoc/../Library/Preferences/optionsData.plist"
Success
fi
fi

SearchApp "Cogs" "Cogs.app" "http://appshopper.com/games/cogs"
if [ $? = 1 ]; then
plutil -key 'Purchases' -type int -value '4' "$tempLoc/../Library/Preferences/com.chillingo.cogs.plist" 2>&1> /dev/null
Success
fi

SearchApp "Cooking Mama" "CookingMama.app" "http://appshopper.com/games/cooking-mama"
if [ $? = 1 ]; then
plutil -key 'save_prch_flag' -type int -value '255' "$tempLoc/../Library/Preferences/R29F49NJNY.jp.co.taito.cookingmama.plist" 2>&1> /dev/null
Success
fi

# This one is from Sirakain and Darksx.
SearchApp "The Creeps (old)" "The Creeps!.app" "http://appshopper.com/games/the-creeps"
if [ $? = 1 ]; then
if [ -e "$tempLoc/../Documents/Stats144.txt" ]; then
foo=$(echo -ne "\xFF" | \
dd bs=1 seek=8 conv=notrunc status=noxfer of="$tempLoc/../Documents/Stats144.txt" 2>&1> /dev/null)
Success
else
echo "  Sorry, unknown version..."
fi
fi

# This one is from Ushnak.
SearchApp "Doodle Devil" "DoodleDevil_appstore_03dec2010.app" "http://appshopper.com/games/doodle-devil"
if [ $? = 1 ]; then
sed --in-place -e 's:money .*:money 9999:g' "$tempLoc/../Documents/config.txt"
Success
fi

SearchApp "DragonSlaughter3" "Shambala.app" "http://appshopper.com/games/dragon-slaughter-ep1"
if [ $? = 1 ]; then
plutil -key '' -value '1' "$tempLoc/../Documents/upgrade1.plist" 2>&1> /dev/null
Success
fi

# This one is from Farhanito.
SearchApp "Echofon for Twitter (not Pro)" "TwitterFon.app" "http://appshopper.com/social-networking/twitterfon"
if [ $? = 1 ]; then
plutil -key 'net.naan.EchofonPro' -type bool -value 'true' "$tempLoc/../Library/Preferences/net.naan.TwitterFon.plist" 2>&1> /dev/null
Success
fi

SearchApp "Finger Physics" "FingerPhysics.app" "http://appshopper.com/games/finger-physics"
if [ $? = 1 ]; then
#       plutil -key 'mail pack' -1 "$tempLoc/../Library/Preferences/com.pressokentertainment.fingerphysics.plist" 2>&1> /dev/null
for x in "pinky" "thumb" "middle"; do
plutil -key "com.pressokentertainment.fingerphysics.$x" -1 "$tempLoc/../Library/Preferences/com.pressokentertainment.fingerphysics.plist" 2>&1> /dev/null
done
Success
fi

# This one is from Tiantou.
SearchApp "FX Photo Studio" "101PhotoFilters.app" "http://appshopper.com/photography/101-photo-filters"
if [ $? = 1 ]; then
for x in "ColorLens" "ColorStroke" "Hollywood1"; do
plutil -key "com.macphun.101PhotoFilters.FX.$x" -1 "$tempLoc/../Library/Preferences/com.macphun.101PhotoFilters.plist" 2>&1> /dev/null
done
Success
fi

SearchApp "Garters & Ghouls" "Garters & Ghouls.app" "http://appshopper.com/games/garters-ghouls"
if [ $? = 1 ]; then
if [ ! -e "$tempLoc/../Library/Preferences/com.namconetworks.gartersandghouls.plist" ]; then
plutil -create "$tempLoc/../Library/Preferences/com.namconetworks.gartersandghouls.plist" 2>&1> /dev/null
chmod 666 "$tempLoc/../Library/Preferences/com.namconetworks.gartersandghouls.plist"
fi
plutil -key 'winter_nightmare' -value '1' "$tempLoc/../Library/Preferences/com.namconetworks.gartersandghouls.plist" 2>&1> /dev/null
Success
fi

SearchApp "Ghosts'n'GoblinsGoldKnights 1 (old)" "V3hwTest.app" "http://appshopper.com/games/ghostsn-goblins-gold-knights"
if [ $? = 1 ]; then
foo=$(echo -ne "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF" | \
dd bs=1 seek=342 conv=notrunc status=noxfer of="$tempLoc/../Documents/sp0.txt" 2>&1> /dev/null)
Success
fi

SearchApp "Ghosts'n'GoblinsGoldKnights 1 (new)" "GHOSTS'N GOBLINS.app" "http://appshopper.com/games/ghostsn-goblins-gold-knights"
if [ $? = 1 ]; then
foo=$(echo -ne "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF" | \
dd bs=1 seek=342 conv=notrunc status=noxfer of="$tempLoc/../Documents/sp1.txt" 2>&1> /dev/null)
Success
fi

SearchApp "Ghosts'n'GoblinsGoldKnights 2" "makaik2en.app" "http://appshopper.com/games/ghostsn-goblins-gold-knights-2"
if [ $? = 1 ]; then
foo=$(echo -ne "\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF\xFF" | \
dd bs=1 seek=342 conv=notrunc status=noxfer of="$tempLoc/../Documents/sp0.txt" 2>&1> /dev/null)
Success
fi

# This one is from Tiantou.
SearchApp "Highborn (SD or HD)" "Highborn.app" "http://appshopper.com/games/highborn"
# http://appshopper.com/games/highborn-hd
if [ $? = 1 ]; then
if [ -e "$tempLoc/../Library/Preferences/net.jetsetgames.HighbornHD.plist" ]; then
plutil -key 'Chapter1Unlock' -1 "$tempLoc/../Library/Preferences/net.jetsetgames.HighbornHD.plist" 2>&1> /dev/null
else
plutil -key 'Chapter1Unlock' -1 "$tempLoc/../Library/Preferences/net.jetsetgames.Highborn.plist" 2>&1> /dev/null
fi
Success
fi

# This one is from Ramsey.
SearchApp "The Impossible Game" "The Impossible Game.app" "http://appshopper.com/games/the-impossible-game-2"
if [ $? = 1 ]; then
if [ ! -e "$tempLoc/../Library/Preferences/com.FlukeDude.TheImpossibleGame.plist" ]; then
plutil -create "$tempLoc/../Library/Preferences/com.FlukeDude.TheImpossibleGame.plist" 2>&1> /dev/null
chmod 666 "$tempLoc/../Library/Preferences/com.FlukeDude.TheImpossibleGame.plist"
fi
plutil -key 'isProUpgradePurchased' -type bool -value 'true' "$tempLoc/../Library/Preferences/com.FlukeDude.TheImpossibleGame.plist" 2>&1> /dev/null
Success
fi

SearchApp "Inspector Gadget Mad Dash" "InspectorGadget.app" "http://appshopper.com/games/inspector-gadgets-mad-dash"
if [ $? = 1 ]; then
if [ ! -e "$tempLoc/../Documents/collectiblesOwned.plist" ]; then
plutil -create "$tempLoc/../Documents/collectiblesOwned.plist" 2>&1> /dev/null
chmod 666 "$tempLoc/../Documents/collectiblesOwned.plist"
fi
plutil -key 'Collectible10' -value 99900 "$tempLoc/../Documents/collectiblesOwned.plist" 2>&1> /dev/null
Success
fi

# This one is from Frigis.
SearchApp "Last Gladiators" "LGR97.app" "http://appshopper.com/games/lgr2010"
if [ $? = 1 ]; then
plutil -key 'paymentstate' -type int -value '255' "$tempLoc/../Library/Preferences/jp.co.bexide.LGR97.plist" 2>&1> /dev/null
Success
fi

# This one is from Sharmanhall.
SearchApp "Logic Box All-in-1" "LogicLand.app" "http://appshopper.com/games/all-in-1-logic-gamebox"
if [ $? = 1 ]; then
plutil -key 'roundUnlocked' -value '1' "$tempLoc/../Documents/Settings.plist" 2>&1> /dev/null
Success
fi

# This one is from Kaikz.
SearchApp "Maxim Magazine" "Maxim.app" "http://appshopper.com/entertainment/maxim-handstand-edition"
if [ $? = 1 ]; then
if [ ! -e /usr/bin/xxd ]; then
echo "Cannot find tool 'xxd'. Install from Cydia."
else
plutil -key 'ISSUES' "$tempLoc/../Library/Preferences/com.bsc.handstand.maxim.plist" | xxd -r -p > "$tempLoc/../Library/Preferences/temp.plist"
plutil -xml "$tempLoc/../Library/Preferences/temp.plist" 2>&1> /dev/null
issues1=$(cat "$tempLoc/../Library/Preferences/temp.plist" | grep "handstand.maxim.issue" | sed -e 's:<string>:\t\":g' -e 's:</string>:\",\t:g' | tr -d ' \n\t')
rm "$tempLoc/../Library/Preferences/temp.plist"
issues2=$(echo "[$issues1!" | sed -e "s:,!:] :g")
plutil -key 'PURCHASED_ISSUES' -type json -value "$issues2" "$tempLoc/../Library/Preferences/com.bsc.handstand.maxim.plist" 2>&1> /dev/null
Success
fi
fi

SearchApp "MegaJump" "Mega Jump.app" "http://appshopper.com/games/mega-jump"
if [ $? = 1 ]; then
plutil -key 'MegaJumpSettings' -key 'mp' -value '99999' "$tempLoc/../Library/Preferences/com.getsetgames.megajump.plist" 2>&1> /dev/null
plutil -key 'MegaJumpSettings' -key 'savestars' -value '99' "$tempLoc/../Library/Preferences/com.getsetgames.megajump.plist" 2>&1> /dev/null
for x in "blueto" "rosie" "buster" "foxworthy" "rocky" "ponpon" "bradley" "chippy" "koko" "ridley" "marty" "biff" "dizzy" "dino" "turtle"; do
plutil -key 'MegaJumpSettings' -key "com.getsetgames.megajump.char.${x}_owned" -value '1' "$tempLoc/../Library/Preferences/com.getsetgames.megajump.plist" 2>&1> /dev/null
done
for x in "antigravity" "luckyblast" "shield" "umbrella" "balloon" "jumpboots"; do
for y in ".mega" ".super" "" ".turbo"; do
plutil -key 'MegaJumpSettings' -key "com.getsetgames.megajump.powerup.${x}${y}_owned" -value '1' "$tempLoc/../Library/Preferences/com.getsetgames.megajump.plist" 2>&1> /dev/null
done
done
for x in "magnet.turbo" "magnet.mega" "supermagnet" "magnet"; do
plutil -key 'MegaJumpSettings' -key "com.getsetgames.megajump.powerup.${x}_owned" -value '1' "$tempLoc/../Library/Preferences/com.getsetgames.megajump.plist" 2>&1> /dev/null
done
for ((x=1;x<21;x++)); do
plutil -key 'MegaJumpSettings' -key "com.getsetgames.megajump.stage.${x}_owned" -value '1' "$tempLoc/../Library/Preferences/com.getsetgames.megajump.plist" 2>&1> /dev/null
done
# com.getsetgames.megajump.wp.wallpaperXX_owned
Success
fi

# This one is from Kaikz.
SearchApp "Ninja Chicken 1 (not Gold)" "Ninja Chicken.app" "http://appshopper.com/games/ninja-chicken"
if [ $? = 1 ]; then
plutil -key 'com.kongzhong.fat.egg' -type bool -value 'true' "$tempLoc/../Library/Preferences/com.kongzhong.fat.plist" 2>&1> /dev/null
Success
fi

SearchApp "Ninja Chicken 2 Shoot'Em Up" "NinjaChicken2.app" "http://appshopper.com/games/ninja-chicken-2shootem-up"
if [ $? = 1 ]; then
plutil -key 'coinCount' -value 22222 "$tempLoc/../Library/Preferences/com.kongzhong.ninja2.plist" 2>&1> /dev/null
Success
fi

SearchApp "Pandorum" "pandorum.app" "http://appshopper.com/games/pandorum"
if [ $? = 1 ]; then
plutil -key 'rmsaddon' -value '1' "$tempLoc/../Documents/RMS.txt" 2>&1> /dev/null
Success
fi

# This one is from Kaikz.
SearchApp "PaperToss (with ads)" "PaperToss.app" "http://appshopper.com/games/paper-toss"
if [ $? = 1 ]; then
plutil -key '__ASSKBC._d' -type bool -value 'true' "$tempLoc/../Library/Preferences/com.backflipstudios.PaperToss.plist" 2>&1> /dev/null
Success
fi

# Thanks to Alidsl
SearchApp "Peggle" "Peggle.app" "http://appshopper.com/games/peggle"
if [ $? = 1 ]; then
plutil -key 'store.nights.unlock' -type bool -value 'true' "$tempLoc/../Library/Preferences/com.popcap.Peggle.plist" 2>&1> /dev/null
Success
fi

# This one is from Tiantou.
#SearchApp "PhotoTreats" "Phototreats.app" "http://appshopper.com/photography/phototreats"
#if [ $? = 1 ]; then
#       plutil -key 'featureAPurchased' -1 "$tempLoc/../Library/Preferences/com.stepcase.phototreats.plist" 2>&1> /dev/null
#       plutil -key 'featureBPurchased' -1 "$tempLoc/../Library/Preferences/com.stepcase.phototreats.plist" 2>&1> /dev/null
#       Success
#fi

SearchApp "Pocket Frogs" "Pocket Frogs.app" "http://appshopper.com/games/pocket-frogs"
if [ $? = 1 ]; then
#       foo=$(echo -ne "\xFF\xFF" | \
#               dd bs=1 seek=8 conv=notrunc status=noxfer of="$tempLoc/../Documents/gd.png" 2>&1> /dev/null)
foo=$(echo -ne "\xFF" | \
dd bs=1 seek=12 conv=notrunc status=noxfer of="$tempLoc/../Documents/gd.png" 2>&1> /dev/null)
foo=$(echo -ne "\xFF" | \
dd bs=1 seek=14 conv=notrunc status=noxfer of="$tempLoc/../Documents/gd.png" 2>&1> /dev/null)
foo=$(echo -ne "\xFF" | \
dd bs=1 seek=60 conv=notrunc status=noxfer of="$tempLoc/../Documents/gd.png" 2>&1> /dev/null)
Success
fi

#SearchApp "Pocket Frogs (alt)" "PocketFrogs1.0.9.app" "http://appshopper.com/games/pocket-frogs"
#if [ $? = 1 ]; then
#       foo=$(echo -ne "\xFF" | \
#               dd bs=1 seek=12 conv=notrunc status=noxfer of="$tempLoc/../Documents/gd.png" 2>&1> /dev/null)
#       foo=$(echo -ne "\xFF" | \
#               dd bs=1 seek=14 conv=notrunc status=noxfer of="$tempLoc/../Documents/gd.png" 2>&1> /dev/null)
#       Success
#fi

SearchApp "Port Defender" "PortDefender.app" "http://appshopper.com/games/port-defender"
if [ $? = 1 ]; then
plutil -key 'purchase_funmode' -type bool -value 'true' "$tempLoc/../Library/Preferences/com.mgatelabs.portdefender.plist" 2>&1> /dev/null
Success
fi

# This one is from Ramsey.
SearchApp "Ramp Champ" "Ramp Champ.app" "http://appshopper.com/games/ramp-champ"
if [ $? = 1 ]; then
plutil -key 'purchasedProducts' -type json -value '["com.iconfactory.RampChampFinal.packs.VoyagePack","com.iconfactory.RampChampFinal.packs.HalloweenPack","com.iconfactory.RampChampFinal.packs.Christmas2009Pack","com.iconfactory.RampChampFinal.packs.AdventurePack","com.iconfactory.RampChampFinal.packs.ChallengePack"]' "$tempLoc/../Library/Preferences/com.iconfactory.RampChampFinal.plist" 2>&1> /dev/null
Success
fi

# This one is from Farhanito.
SearchApp "RemoteX Premium" "RemoteX.app" "http://appshopper.com/utilities/remotex-control-pc-18-media-players-and-more"
if [ $? = 1 ]; then
plutil -key 'buyAll' -type bool -value 'true' "$tempLoc/../Library/Preferences/com.peepleware.remotex.plist" 2>&1> /dev/null
Success
fi

SearchApp "Retro Game One IntelliVision" "Intellivision iPhone.app" "http://appshopper.com/games/vh1-classic-presents-intellivision"
if [ $? = 1 ]; then
echo -ne "Salted__v\x82\x35\xCD\x99!;\xDD\xEC\xB0\xA6\x61\xAC\xDE\x9\x8DL\xC1\xBA\x1E\xBF|n,\xE2H\xB5\xF7\xFB\x34\x90\xD4\xFA<\x44\xAF#i&\xD3IO\xB\x92\x62\xAE\x41@\x14j\x66\x3Zi\x62\x13\xC0k\xA0\xD2G\xBE\xA8\xDD$\x11g\xE8\x83=\xD\x92\xF4|{\x13\x88\xCF\xD6T\x9F\xB2\xCF-ws\x64\x6" \
> "$tempLoc/../Documents/com.mtvn.vh1intellivision.chipshotgolf.cert"
chmod 666 "$tempLoc/../Documents/com.mtvn.vh1intellivision.chipshotgolf.cert"
echo -ne "Salted__\xC3wU\x97\x9B(\x8C\xE3\x85\xCA\xB1,\x84\xCC\xF3\x87\xA7\x41\xD5\xE1\x93\x64\xE2\x35\x15\x8Fh\xDB\xAF\xD5 \xF1\xB3n\x19\x95'\x9B\x91\xC5\x88\x95\xC3;@\xA9j\xC3\xCD\xE3\x9C\x44\xE3\xFD]\x86" \
> "$tempLoc/../Documents/com.mtvn.vh1intellivision.nightstalker.cert"
chmod 666 "$tempLoc/../Documents/com.mtvn.vh1intellivision.nightstalker.cert"
echo -ne "Salted__k\x19\x9B\xB0\xD6\xFC\xF2\x80\x14\xBB\x8Fk\xBA\x1F\x34\xD4\x11\xC8\x15\x96p_;\xF8\xB6\x80\xA1\xA1X v?TL\x17\xD2\x7FSP\x14+\xFA\xAE\x1C\xBE\x9B:\xAC\x87\xE8\x61L\x9EU\xEC\x85\xDCL}R\x5C\x80x\xB4\xA1\xB8\x7\x0W\xC9\x16(" \
> "$tempLoc/../Documents/com.mtvn.vh1intellivision.skiing.cert"
chmod 666 "$tempLoc/../Documents/com.mtvn.vh1intellivision.skiing.cert"
echo -ne "Salted__\xEB\xF6\xE0\x95:\x9AI'\xF\x42\xB4K\x92\x5=\xACH\x43\xBC/\x33Q\xB6\x63\xA1|p \xCC\xA4\x15\xB3\x33y;\xCE|J\xB2u\xBD:\xB1*\x8D\xB1\x6\x46r\xD0=n\x42\x0i\x1D" \
> "$tempLoc/../Documents/com.mtvn.vh1intellivision.thinice.cert"
chmod 666 "$tempLoc/../Documents/com.mtvn.vh1intellivision.thinice.cert"
echo -ne "Salted__\xF2'i\x1\xB0\x84\xFD\x9Bj\xC0t\x1\xD4\xCA\xF5\x9\x41J\x8A\x85\xCD\xEB\x11\x8B\xE1\xAD\x9C\xA)\x6\xD3\xAF\x62\xF1\x44@\x19;\xEB\xD6\xA4\x9C:N|\xF6Y\xFB\xFB\x9\xE0\xEC\x84Z\x42\xF3{z\xEB\xED>M\xFE?\x86L\x86\xF7y}\x10H" \
> "$tempLoc/../Documents/com.mtvn.vh1intellivision.thundercastle.cert"
chmod 666 "$tempLoc/../Documents/com.mtvn.vh1intellivision.thundercastle.cert"
Success
fi

# You should really buy issues.
#SearchApp "Retro Gamer UK Magazine" "Retro Gamer.app" "http://appshopper.com/books/retro-gamer-magazine"
#if [ $? = 1 ]; then
#       if [ ! -e /usr/bin/sqlite3 ]; then
#               echo "Cannot find tool 'sqlite'. Install from Cydia."
#       else
#               sqlite3 "$tempLoc/../Documents/PixelMags.sqlite" 'update zissue set zpmispurchased=1 where ztype="issue";'
#               Success
#       fi
#fi
# Their other magazines should work the same way

#SearchApp "Road Blaster" "RoadBlaster.app" "http://appshopper.com/games/road-blaster"
#if [ $? = 1 ]; then
#       if [ ! -e /usr/bin/xxd ]; then
#               echo "Cannot find tool 'xxd'. Install from Cydia."
#       else
#               plutil -key 'optionsData' "$tempLoc/../Library/Preferences/com.revolutionaryconcepts.roadblaster.plist" | xxd -r -p > "$tempLoc/../Library/Preferences/optionsData.plist"
#               plutil -xml "$tempLoc/../Library/Preferences/optionsData.plist" 2>&1> /dev/null
#               cat "$tempLoc/../Library/Preferences/optionsData.plist" | tr -d '\t','\n' | \
#               sed -e 's=<key>purchasedAllLevels</key><false/>=<key>purchasedAllLevels</key><true/>=g' \
#                       -e 's=<key>purchasedGodMode</key><false/>=<key>purchasedGodMode</key><true/>=g' \
#                       -e 's=<key>purchasedUnlimitedLives</key><false/>=<key>purchasedUnlimitedLives</key><true/>=g' \
#                       > "$tempLoc/../Library/Preferences/optionsData2.plist"
#               plutil -binary "$tempLoc/../Library/Preferences/optionsData2.plist" 2>&1> /dev/null
#               plutil -key 'optionsData' -data "$tempLoc/../Library/Preferences/optionsData2.plist" "$tempLoc/../Library/Preferences/com.revolutionaryconcepts.roadblaster.plist" 2>&1> /dev/null
#               rm "$tempLoc/../Library/Preferences/optionsData2.plist"
#               rm "$tempLoc/../Library/Preferences/optionsData.plist"
#               Success
#       fi
#fi

# This one is from Ramsey.
# SearchApp "Robozzle" "Robozzle.app"
# if [ $? = 1 ]; then
#       plutil -key 'fullVersionUnlocked' -type bool -value 'true' "$tempLoc/../Library/Preferences/com.bridgermaxwell.Robozzle.plist" 2>&1> /dev/null
#       Success
# fi

SearchApp "Run Like Hell (not Deluxe)" "rlh_reborn_in_app_purchase_distribution.app" "http://appshopper.com/games/run-like-hell-2"
if [ $? = 1 ]; then
sed --in-place -e 's:purchased="0":purchased="1":g' "$tempLoc/../Documents/rlh.xml"
Success
fi

SearchApp "Seat Cupra Race 2" "CupraRace25.app" "http://appshopper.com/games/seat-cupra-race-2"
if [ $? = 1 ]; then
foo=$(echo -ne "\x03" | \
dd bs=1 seek=104 conv=notrunc status=noxfer of="$tempLoc/../Documents/BestPersonal" 2>&1> /dev/null)
Success
fi

SearchApp "Super Slyder" "SuperSlyder.app" "http://appshopper.com/games/super-slyder"
if [ $? = 1 ]; then
if [ ! -e /usr/bin/wget ]; then
echo "Cannot find tool 'wget'. Install from Cydia."
else
if [ ! -e "$tempLoc/../Documents/RetailPacks" ]; then
mkdir "$tempLoc/../Documents/RetailPacks"
chmod 777 "$tempLoc/../Documents/RetailPacks"
fi
cd "$tempLoc/../Documents/RetailPacks"
PackDown=$(plutil -key 'retailPacksNames' -key '0' -key 'isDownloaded' "$tempLoc/../Library/Preferences/com.sandlotgames.superslyder.plist" 2> /dev/null)
if [ "$PackDown" = "NO" ]; then
if [ ! -e "110423001.xml" ]; then
echo -n "Downloading level pack 1... "
wget --quiet http://sandlot.sandlotgames.com/SuperSlyder/RetailPackXML/Sparkys_Snare.xml 2>&1> /dev/null
if [ ! -e "Sparkys_Snare.xml" ]; then
echo "KO"
else
chmod 666 "Sparkys_Snare.xml"
mv "Sparkys_Snare.xml" "110423001.xml"
plutil -key 'retailPacksNames' -key '0' -key 'isDownloaded' -value 'YES' "$tempLoc/../Library/Preferences/com.sandlotgames.superslyder.plist" 2>&1> /dev/null
echo "OK"
Success
fi
fi
fi
PackDown=$(plutil -key 'retailPacksNames' -key '1' -key 'isDownloaded' "$tempLoc/../Library/Preferences/com.sandlotgames.superslyder.plist" 2> /dev/null)
if [ "$PackDown" = "NO" ]; then
if [ ! -e "110423002.xml" ]; then
echo -n "Downloading level pack 2... "
wget --quiet http://sandlot.sandlotgames.com/SuperSlyder/RetailPackXML/Ungers_Jungle.xml 2>&1> /dev/null
if [ ! -e "Ungers_Jungle.xml" ]; then
echo "KO"
else
chmod 666 "Ungers_Jungle.xml"
mv "Ungers_Jungle.xml" "110423002.xml"
plutil -key 'retailPacksNames' -key '1' -key 'isDownloaded' -value 'YES' "$tempLoc/../Library/Preferences/com.sandlotgames.superslyder.plist" 2>&1> /dev/null
echo "OK"
Success
fi
fi
fi
cd - 2>&1> /dev/null
fi
fi

# This one is from Tiantou.
SearchApp "Tilt To Live" "Tilt To Live.app" "http://appshopper.com/games/tilt-to-live"
if [ $? = 1 ]; then
plutil -key 'turretsSyndromeUnlockKey' -value '1' "$tempLoc/../Library/Preferences/com.OneManLeft.TiltToLive.plist" 2>&1> /dev/null
Success
fi

# This one is from Tiantou.
SearchApp "Tilt To Live HD" "Tilt To Live HD.app" "http://appshopper.com/games/tilt-to-live-hd"
if [ $? = 1 ]; then
plutil -key 'IAPFullVersionPurchased' -1 "$tempLoc/../Library/Preferences/com.onemanleft.tilttolivehd.plist" 2>&1> /dev/null
plutil -key 'IAPVivaLaTurretPurchased' -1 "$tempLoc/../Library/Preferences/com.onemanleft.tilttolivehd.plist" 2>&1> /dev/null
Success
fi

SearchApp "TurboGrafx GameBox (Nec PC Engine)" "iPhone_PCE_en.app" "http://appshopper.com/games/turbografx-16-gamebox"
if [ $? = 1 ]; then
for x in "001genjin1" "005nectaris" "006victory" "007bouken" "008sblade" "010rtype" "011necro" "012dungeon" "014bomber94" "015vigilante" "017snindo" "018kunfu" "020gradius" "021salamander" "024wcbaseball"; do
plutil -key "jp.co.hudson.t16box01.$x" -type bool -value 'true' "$tempLoc/../Library/Preferences/jp.co.hudson.t16box01.plist" 2>&1> /dev/null
done
Success
fi

# This one is from Cybot2006.
SearchApp "Twitterrific" "Twitterrific.app" "http://appshopper.com/social-networking/twitterrific-for-ipad"
if [ $? = 1 ]; then
plutil -key 'isUpgradePurchased' -type bool -value 'true' "$tempLoc/../Library/Preferences/com.iconfactory.Flamingo.plist" 2>&1> /dev/null
Success
fi

SearchApp "ZitPicker" "Zit\ Picker.app" "http://appshopper.com/entertainment/zit-picker-%E2%98%85"
if [ $? = 1 ]; then
plutil -key 'myFriendsKey' -type int -value '1' "$tempLoc/../Documents/myFriends.plist" 2>&1> /dev/null
Success
fi

SearchApp "Zombie Café" "ZombieCafe.app" "http://appshopper.com/games/zombie-cafe"
if [ $? = 1 ]; then
if [ ! -e /usr/bin/xxd ]; then
echo "Cannot find tool 'xxd'. Install from Cydia."
else
plutil -key 'SaveData:globalData' "$tempLoc/../Library/Preferences/com.capcommobile.zombiecafe.plist" | xxd -r -p > "$tempLoc/../Library/Preferences/temp.bin"
foo=$(echo -ne "\xFF" | \
dd bs=1 seek=16 conv=notrunc status=noxfer of="$tempLoc/../Library/Preferences/temp.bin" 2>&1> /dev/null)
plutil -key 'SaveData:globalData' -data "$tempLoc/../Library/Preferences/temp.bin" "$tempLoc/../Library/Preferences/com.capcommobile.zombiecafe.plist" 2>&1> /dev/null
rm "$tempLoc/../Library/Preferences/temp.bin"
Success
fi
fi

# # # # #
if [ $listing = 0 ]; then
#Apps list not needed anymore
rm -f /tmp/lsd.tmp

echo
echo -n "Successfully DLC'ed $number apps"
if [ ! -z "$ListApp" ]; then
echo ": $ListApp."
else
echo "."
fi
echo "Thanks."
fi
#
#!/bin/bash
#
# Quick'n'dirty tool to build a Pidgin theme from this repository.
# Run from the directory you checked out of!
# Don't forget to modify the DEFAULT_THEME_PATH if your pidgin
# is installed somewhere different.

BASE="hipchat"
OUTPHILE="${BASE}/theme"
DEFAULT_THEME_PATH="/usr/share/pixmaps/pidgin/emotes/default"

### Ideally, don't modify anything below this line ###
cd Hipchat.AdiumEmoticonSet

if [ ! -d "${BASE}" ]; then
	mkdir -p "${BASE}"
fi


if [ -e "${OUTPHILE}" ]; then
	rm "${OUTPHILE}"
fi

# Write out the header file
cat > ${OUTPHILE} <<EOF
Name=HipChat
Description=HipChat smileys
Icon=atlassian.png
Author=No Clue

[default]
happy.png           :)      :-)
excited.png         :-D     :-d     :D      :d
sad.png             :-(     :(
wink.png            ;-)     ;)
tongue.png          :P      :p      :-P     :-p
shocked.png         =-O     =-o
kiss.png            :-*
glasses-cool.png    8-)
embarrassed.png     :-[
crying.png          :'(     :'-(
thinking.png        :-/     :-\\
angel.png           O:-)    o:-)
shut-mouth.png      :-X
moneymouth.png      :-$
foot-in-mouth.png   :-!
shout.png           >:o     >:O
! skywalker.png     C:-)    c:-)    C:)     c:)
! monkey.png        :-(|)   :(|)    8-|)
! cyclops.png       O-)     o-)

# Atlassian hipchat smileys
[XMPP]
EOF

# Now write out the Atlassian custom symbology
for i in png gif jpeg; do
	for j in *.${i}; do 
		echo -e "$j\t\t(`basename ${j} .${i}`)" >> ${OUTPHILE};
	done
done

# Copy the files into the new directory
cp *.{png,gif,jpeg} ${BASE}

# Copy the default smileys into the new theme so we don't lose them.
for def in happy excited sad wink tongue shocked kiss "glasses-cool" embarrassed crying thinking angel "shut-mouth" moneymouth "foot-in-mouth" shout skywalker monkey cyclops; do
	cp ${DEFAULT_THEME_PATH}/"${def}.png" ${BASE}
done

echo "done!"
echo "at this point: sudo mv Hipchat.AdiumEmoticonSet/hipchat /usr/share/pixmaps/pidgin/emotes/ and restart pidgin to get the new theme!"
cd -
exit 0

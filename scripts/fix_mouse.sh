#/bin/bash

set -e

# Author:      osxi
# Date:        01/01/2016
# Description: Prevent the R.A.T.7 mouse in X11 from having focus issues.
# Usage:       ./fix_mouse.sh
#
#              This script works by ignoring buttons 13, 14, and 15, which are
#              known to cause focus issues in X11. Ensure that this script is
#              executable. You can also invoke this script using
#              `DEBUG=1 ./fix_mouse.sh` to get debug logging for this various
#              variables that should be automatically set for you.
# References:  https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-evdev/+bug/615892
#              https://wiki.archlinux.org/index.php/Mad_Catz_Mouse

NAME="Saitek Cyborg R.A.T.7 Mouse"
BUTTONS="1 2 3 4 5 6 7 8 9 10 11 12 0 0 0 16 17 18 19 20 22"
OBLIVION="/dev/null"
ERROR_MESSAGE="Something went wrong..."
SUCCESS_MESSAGE="Successfully set buttons for $NAME"
ID_PATTERN="s/.*id=\([0-9]\{1,2\}\).*/\1/p"
ID="$(xinput list "$NAME" 2> $OBLIVION | sed -n $ID_PATTERN)"

if [ -n "$DEBUG" ]; then
  debug
fi

{
  set_buttons
} || {
  catch_error
}

set_buttons () {
  xinput --set-button-map $ID $BUTTONS 2> $OBLIVION && \
  echo $SUCCESS_MESSAGE
}

catch_error () {
  echo $ERROR_MESSAGE
  exit 1
}

debug () {
  echo "DEBUG MODE"
  echo "----------"
  echo "NAME: $NAME"
  echo "ID_PATTERN: $ID_PATTERN"
  echo "ID: $ID"
}

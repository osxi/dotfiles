#/bin/bash

set -e

NAME="Saitek Cyborg R.A.T.7 Mouse"
BUTTONS="1 2 3 4 5 6 7 8 9 10 11 12 0 0 0 16 17 18 19 20 22"
OBLIVION="/dev/null"
ERROR_MESSAGE="Something went wrong..."
SUCCESS_MESSAGE="Successfully set buttons for $NAME"
ID_PATTERN="s/.*id=\([0-9]\{1,2\}\).*/\1/p"
ID="$(xinput list "$NAME" 2> $OBLIVION | sed -n $ID_PATTERN)"

if [ -n "$DEBUG" ]; then
  echo "DEBUG MODE"
  echo "----------"
  echo "NAME: $NAME"
  echo "ID_PATTERN: $ID_PATTERN"
  echo "ID: $ID"
fi

{
  xinput --set-button-map $ID $BUTTONS 2> $OBLIVION && \
  echo $SUCCESS_MESSAGE
} || {
  echo $ERROR_MESSAGE
  exit 1
}

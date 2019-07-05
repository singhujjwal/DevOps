#!/bin/bash
MSGBOX=${MSGBOX=dialog}
TITLE="Default"
MESSAGE="Some Message"
XCOORD=10
YCOORD=20


funcDisplayMsgBox(){
  $MSGBOX --title "$1" --msgbox "$2" "$3" "$4"
}


if [ "$1"=="ls" ];then
  funcDisplayMsgBox "WARNING!" "Please press OK when you are ready see the list of files" "10" "20"
  echo "executing command now!!!!"
  $1
else
  funcDisplayMsgBox "Boring..." "You are not asking for anything fun..." "10" "20"
  echo "Not doing anything, back to regular scripting..."
fi

#!/usr/bin/env bash

execute() {
  local x=0
  local y=0
  local index=0
  local directions=("N" "E" "S" "W")

  move() {
    if [ ${directions[index]} = "N" ]
    then
      y=$((y+1))
      if [ "$y" -gt 9 ]
      then
        y=0
      fi
    elif [ ${directions[index]} = "E" ]
    then
      x=$((x+1))
      if [ "$x" -gt 9 ]
      then
        x=0
      fi
    elif [ ${directions[index]} = "W" ]
    then
      x=$((x-1))
      if [ "$x" -lt 0 ]
      then
        x=9
      fi
    elif [ ${directions[index]} = "S" ]
    then
      y=$((y-1))
      if [ "$y" -lt 0 ]
      then
        y=9
      fi
    fi
  }

  rotate_right() {
    index=$((index+1))
    if [ "$index" -gt 3 ]
    then
      index=0
    fi
  }

  rotate_left() {
    index=$((index-1))
    if [ "$index" -lt 0 ]
    then
      index=3
    fi
  }

  for cmd in $(echo "$1" | sed -e 's/\(.\)/\1\n/g')
  do
    case "$cmd" in
      "M")
        move
        ;;
      "R")
        rotate_right
        ;;
      "L")
        rotate_left
        ;;
    esac
  done

  echo "$x:$y:${directions[index]}"
}

execute $1

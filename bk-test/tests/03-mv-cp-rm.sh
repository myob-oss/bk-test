#!/usr/bin/env bash

dir1=$(mktemp -d)
dir2=$(mktemp -d)
file1="$dir1"/a.txt
file2="$dir1"/b.txt
file3="$dir2"/a.txt
file4="$dir2"/b.txt
touch "$file1"
touch "$file2"
touch "$file3"
touch "$file4"

code=0

run() {
  timeout --foreground 2s "$@"
  case "$?" in
    0)
      echo "$1 succeeded"
      ;;
    124)
       echo -e "\\ntimeout: could not $1 file" && code=1
      ;;
    125)
      echo -e "\\ntimeout command failed" && code=1
      ;;
    126)
      echo -e "\\ncould not invoke $1" && code=1
    ;;
    127)
      echo -e "\\nwtf $1 not found?" && code=1
      ;;
    137)
      echo -e "\\n$1 killed(9)" && code=1
      ;;
    *)
      echo -e "\\nunknown error with $1" && code=1
  esac
}

echo "~~~ mv"
run mv "$file1" "$file2"
echo "~~~ cp"
run cp "$file2" "$file4"
echo "~~~ rm"
run rm "$file3"
exit "$code"

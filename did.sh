#!/bin/bash
#!/usr/bin/env fish

# CONSTANTS
DID_FILE_PATH=~/did.txt

# SETUP
function create_did_file() {
  touch "$DID_FILE_PATH"
}

# WRITING/READING
function date_present() {
  did=`cat $DID_FILE_PATH`
  matches=`grep $1 $DID_FILE_PATH -F -x -c`
  if [ $matches >= 1 ]; then
    return 1
  else
    return 0
  fi
}

# MAIN
if [ -f "$DID_FILE_PATH" ]; then
  # List of arguments possible (in the future)
  # -o open
  # -d add at date
  # -D open at date
  # -g get for date
  # none matching: add string as bullet point for today
  # get the above working first
  date=$(date +"%m-%d-%y")
  if date_present $date; then
    # TODO: Get actual line we need
    vi +2 $DID_FILE_PATH
  else
    echo 'foo' # need to do something here to prevent error
  fi
else 
  create_did_file
fi


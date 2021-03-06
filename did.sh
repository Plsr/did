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
  if [[ $matches -ge 1 ]]; then
    return 0
  else
    return 1
  fi
}

function open_at_current_date() {
  date=$(date +"%m-%d-%y")
  if date_present $date; then
    line=`grep $date $DID_FILE_PATH -F -x -n | cut -d : -f 1`
    vi +$line $DID_FILE_PATH 
  else
    # Add the date as a headline to end of file
    # Then open editor
    echo -en '\n' >> $DID_FILE_PATH
    echo $date >> $DID_FILE_PATH
    echo -en '\n' >> $DID_FILE_PATH
    line=`wc -l $DID_FILE_PATH | cur -d : -f 1`
    vi +$line $DID_FILE_PATH
  fi
}

# MAIN
# Things for the future:
# - Check if there is a newline at the end of the file
#   If not, add it and place the curser there
# - Make did file path configurable somehow
# - Make editor configureable (probably best to use $EDITOR)
#   - See if $VISUAL is set, if so use that
#   - If not, see if $EDITOR is set and use that
#   - If none is set, just use vi
# - allow List of arguments
#   -o open
#   -d add at date
#   -D open at date
#   -g get for date
# none matching: add string as bullet point for today
# get the above working first
if ! [ -f "$DID_FILE_PATH" ]; then
  create_did_file
fi
open_at_current_date


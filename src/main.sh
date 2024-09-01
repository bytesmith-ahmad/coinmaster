#!/bin/bash

# load meta data here then send to main logic

export SRC_HOME="$HOME/src/coinmaster"
source "$SRC_HOME/src/coinmaster.sh"
main "$@"

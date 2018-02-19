##!/usr/bin/env bash

# Startupscript for the different emacs examples included.

# Print usage
usage() {
    printf "Usage: \n$0 <path to init.el>\n"
    printf "\nInit files:\n"
    find $(dirname $0) -name init.el
}

# One inputfile needed
if [ $# -ne 1 ]
then
    printf "Error: No inputfile\n\n"
    usage
elif [ -f $1 ]   # If the file exists
then
    initfile=$(basename $1)
    dir=$(dirname $1)
    # Start Emacs with the initfile as option. 
    emacs --no-init-file --chdir ${dir} --load ${initfile} ${initfile}
else
    printf "Error: No such file: $initfile\n\n"
    usage
fi

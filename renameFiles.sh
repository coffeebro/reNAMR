#!/bin/bash

#################################################################
# This script was written to change the names of files that are #
# named in an incremental fashion.				#
#								#
# Usage: ./renameFiles.sh <directory> <number>			#
# 			  	<extension> <test|final>	#
#								#
# Next step: package the error checking into a function		#
#################################################################

USAGE="Usage: $0 <path_to_files_to_rename> <number_to_start_renaming> <extension> <test|final>"

if ! [ -d "$1" ]; then
	echo "Error: directory not supplied or does not exist"
	echo $USAGE
	exit 1
fi
if ! [ $2 -eq $2 2> /dev/null ]; then
	echo "Error: number to start renaming scheme not supplied"
	echo $USAGE
	exit 1
fi
if ! [[ $4 = "test" ]] && ! [[ $4 = "final" ]]; then
	echo "Error: need to specify test or final mode"
	echo $USAGE
	exit 1
fi
if [ "$#" -ne 4 ]; then
	echo "Error: insufficient number of arguments"
	echo $USAGE
	exit 1
fi

EXT=".$3"
FILES="$1*$EXT"
NUM=$2

echo "Target: $FILES"

if [[ $4 = "test" ]]; then
	for i in $FILES
	do
		if [ $NUM -lt 10 ]; then
			echo "Renaming $i to $1IMG_000$NUM$EXT"
			let NUM++
		elif [ $NUM -lt 100 ]; then
			echo "Renaming $i to $1IMG_00$NUM$EXT"
			let NUM++
		elif [ $NUM -lt 1000 ]; then
			echo "Renaming $i to $1IMG_0$NUM$EXT"
			let NUM++
		elif [ $NUM -ge 1000 ]; then
			echo "Renaming $i to $1IMG_$NUM$EXT"
			let NUM++
		fi
	done
fi

if [[ $4 = "final" ]]; then
	for i in $FILES
        do
                if [ $NUM -lt 10 ]; then
			NEW="IMG_000"
                        mv $i $1$NEW$NUM$EXT
                        let NUM++
                elif [ $NUM -lt 100 ]; then
			NEW="IMG_00"
			mv $i $1$NEW$NUM$EXT
                        let NUM++
                elif [ $NUM -lt 1000 ]; then
			NEW="IMG_0"
			mv $i $1$NEW$NUM$EXT
                        let NUM++
                elif [ $NUM -ge 1000 ]; then
			NEW="IMG_"
			mv $i $1$NEW$NUM$EXT
                        let NUM++
                fi
        done
fi

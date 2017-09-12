#!/bin/bash

#This script is used to enforce the naming convention
#of capitals of all the letters after the underscores as well
#as the first character


#Error Constants
INVAL_ARG=55
INVAL_DIR=56

#Error Function Handler
function error_function {
	case $1 in
		"$INVAL_ARG")
			echo "Invalid Number of Arguments... Usage $0 directory"
		;;
		"$INVAL_DIR")
			echo "The Argument Given is not a Directory... Usage $0 directory"
		;;
	esac
	
	exit $1
}

#Argument Number Handler
if [ $# -gt 1 ] || [ $# -lt 1 ]; then
	error_function $INVAL_ARG
fi

#Directory Argument Handler
if [ ! -d "$1" ]; then
	error_function $INVAL_DIR
fi

#Renaming For Loop
new_file=

for file in ${1}/*; do
	
	new_file=${1}/$(echo "$(basename "$file")" | sed 's/[^ _-]*/\u&/g')
	
	if [ ! -a "$new_file" ] && [ "$file" != "$new_file" ]; then
		if [ -d "$file" ]; then				#Recursive Directory Call
			mv "$file" "$new_file" 
			./$0 "$new_file"
		elif [ -f "$file" ]; then			#Regualar File Call
			mv "$file" "$new_file"
		fi
	fi
	
done

exit 0
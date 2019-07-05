#!/bin/bash
echo "Hi this is some basic bash scripting practice"

# Parameter passing also $ is special so you can escape it
echo "The first parameter is \${0} ${0} which is the filename"
echo "The list of parameters is defined by \$@"


for arg in "$@"
	do
		if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]; then
			echo "Print the help here"
			exit 0
		fi
		echo "The args in the script is $arg"
		sleep 1
	done
sleep 5
echo "The below snippet will loop through a directory and list the files"
# for loop across a list of files
for file in /tmp/*
	do
		echo "The file name is $file and this is also ${file}"
		sleep 1
	done


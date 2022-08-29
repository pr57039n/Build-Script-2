#!/bin/bash

#Pat Reynolds; 8/11/22; This script breaks if you type a, n or a singular character on process close
#this script also fails to work if you don't exactly properly type a process name when attempting to kill

#This section is to print the current memory being used then prompt the user if memory usage exceeds 50 percent
#This can also be modified to show criteria like CPU as well.


printf "Memory\n"
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
echo "$MEMORY"
MEMORY2=$( echo "$MEMORY" | cut -c 1,2,4,5 )
        if [ "$MEMORY2" -le 5000 ]; then
        echo "Memory usage is currently under 50 percent"
elif
        echo "Memory usage is currently over 50 percent"
	then
			read -p "Would you like to check the top consuming processes? " reply
fi
replyfix=$( echo "$reply" | cut -c 1 | tr [:upper:] [:lower:] )

#The intent here is if the user wishes to see the current running processes then this will print the top consumers to the shell

if [ "$replyfix" = y ];
 then
        ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 5
else
        exit 0
fi

#Next is to prompt the user if they wish to close a process based on the information they recieved.

read -p "Would you like to close a process? " ans

ans2=$( echo "$ans" | cut -c 1 | tr [:upper:] [:lower:] )

if [ "$ans2" = y ]; then
	read -p "Please enter the name of the process to kill: " pname
fi
if [ "pname" = a ] || [ "pname" = n ]; then
	echo "This is not a valid process name."
else
	pkill -15 $pname
	echo Attempted to close "$pname".
fi

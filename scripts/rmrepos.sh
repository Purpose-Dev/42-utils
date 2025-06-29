#!/bin/sh

if [ "$#" -ne 2 ]; then
	printf "%b\n" "\033[31mError: \033[0mUsage: rmrepos <string> <number>"
	exit 1
fi

str="$1"
nbr="$2"

case "$nbr" in
*[!0-9]*)
	printf "%b\n" "\033[31mError: \033[0mNumber argument must be a positive integer."
	exit 1
	;;
"")
	printf "%b\n" "\033[31mError: \033[0mNumber argument cannot be empty."
	exit 1
	;;
esac

i=0
while [ "$i" -lt "$nbr" ]; do
	if [ "$i" -lt 10 ]; then
		j="0$i"
	else
		j="$i"
	fi

	dir_name="${str}${j}"

	if [ ! -d "$dir_name" ]; then
		printf "%b\n" "\033[33mWarning: \033[0mdirectory ${dir_name} does not exist"
		i=$((i + 1))
		continue
	fi

	if ! rm -r "$dir_name"; then
		printf "%b\n" "\033[31mError: \033[0mfailed to remove directory ${dir_name}"
		exit 1
	fi

	printf "%b\n" "\033[32mRemoved directory: \033[0m${dir_name}"
	i=$((i + 1))
done

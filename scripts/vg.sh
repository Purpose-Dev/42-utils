#!/bin/sh

if [ "$#" -lt 1 ]; then
	printf "%b\n" "\033[31mError: \033[0mUsage: $0 <executable_name> [args...]"
	exit 1
fi

executable_name="$1"
shift

if [ ! -f "$executable_name" ]; then
	printf "%b\n" "\033[31mError: \033[0mExecutable '$executable_name' not found."
	exit 1
fi

if [ ! -x "$executable_name" ]; then
	printf "%b\n" "\033[31mError: \033[0m'$executable_name' is not an executable."
	exit 1
fi

printf "%b\n" "\033[34mRunning Valgrind on '$executable_name'...\033[0m"

if valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes --track-fds=yes --num-callers=42 --error-exitcode=42 --log-file=valgrind.log --verbose ./"$executable_name" "$@"; then
	printf "%b\n" "\033[32mValgrind finished. Check valgrind_report.txt for details.\033[0m"
else
	printf "%b\n" "\033[31mValgrind encountered an issue. Check valgrind_report.txt for details.\033[0m"
fi

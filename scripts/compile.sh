#!/bin/sh

if [ "$#" -lt 1 ]; then
	printf "%b\n" "\033[31mError: \033[0mUsage: $0 <input_file1.c> [input_file2.c ...] [output_file] [--debug]"
	exit 1
fi

input_files=""
output_file=""
debug_mode=0
args_collected=""

while [ "$#" -gt 0 ]; do
	case "$1" in
	--debug)
		debug_mode=1
		shift
		;;
	*)
		args_collected="$args_collected $1"
		shift
		;;
	esac
done

potential_input_files=""
potential_output_file=""

for arg in $args_collected; do
	if [ -f "$arg" ] && printf "%s" "$arg" | grep -q '\.c$'; then
		potential_input_files="$potential_input_files \"$arg\""
	else
		potential_output_file="$arg"
	fi
done

input_files="$potential_input_files"

if [ -n "$potential_output_file" ]; then
	output_file="$potential_output_file"
fi

if [ -z "$input_files" ]; then
	printf "%b\n" "\033[31mError: \033[0mNo input .c files specified or found."
	exit 1
fi

if [ -z "$output_file" ]; then
	first_input_file_for_name=$(printf "%s" "$input_files" | sed 's/^"//; s/".*//')

	if [ -n "$first_input_file_for_name" ]; then
		output_file=$(printf "%s" "$first_input_file_for_name" | sed 's/\.c$//')
	fi

	if [ -z "$output_file" ]; then
		output_file="a.out"
	fi
fi

compile_command="cc -Wall -Wextra -Werror"

if [ "$debug_mode" -eq 1 ]; then
	compile_command="$compile_command -g2"
fi

compile_command="$compile_command $input_files -o \"$output_file\""

printf "%b\n" "\033[34mStarting compilation...\033[0m"
printf "%b\n" "\033[35mCommand:\033[0m $compile_command"

if eval "$compile_command"; then
	printf "%b\n" "\033[32mCompilation successful! Output: \033[0m$output_file"
else
	printf "%b\n" "\033[31mCompilation failed! Please check your code.\033[0m"
	exit 1
fi

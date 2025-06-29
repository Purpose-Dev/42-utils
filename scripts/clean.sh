#!/bin/sh

executables_removed=0
o_files_removed=0

printf "%b\n" "\033[34mStarting cleanup...\033[0m"

temp_exec_list=$(mktemp)

find . -type f -perm -u+x ! -name "$(basename "$0")" -print >"$temp_exec_list"

while IFS= read -r file; do
	if rm "$file"; then
		executables_removed=$((executables_removed + 1))
		printf "%b\n" "  \033[36mRemoved:\033[0m $file"
	else
		printf "%b\n" "  \033[31mError removing:\033[0m $file"
	fi
done <"$temp_exec_list"

rm "$temp_exec_list"

temp_o_list=$(mktemp)

find . -type f -name "*.o" -print >"$temp_o_list"

while IFS= read -r file; do
	if rm "$file"; then
		o_files_removed=$((o_files_removed + 1))
		printf "%b\n" "  \033[36mRemoved:\033[0m $file"
	else
		printf "%b\n" "  \033[31mError removing:\033[0m $file"
	fi
done <"$temp_o_list"

rm "$temp_o_list"

printf "%b\n" "\n\033[32mCleanup complete!\033[0m"
printf "%b\n" "\033[32m  Executables removed:\033[0m $executables_removed"
printf "%b\n" "\033[32m  .o files removed:\033[0m $o_files_removed"

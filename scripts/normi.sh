#!/bin/sh

rule="CheckForbiddenSourceHeader"
target_path="."
file_type_hint="C files"

while [ "$#" -gt 0 ]; do
	case "$1" in
	--define)
		rule="CheckDefine"
		file_type_hint="Header files (.h)"
		shift
		;;
	*)
		target_path="$1"
		shift
		;;
	esac
done

printf "%b\n" "\033[34mRunning Norminette with rule '$rule' on '$target_path' (likely $file_type_hint)...\033[0m"

tmp_norminette_output=$(mktemp)
tmp_norminette_status=$(mktemp)

norminette -R "$rule" "$target_path" >"$tmp_norminette_output"
echo "$?" >"$tmp_norminette_status"

norminette_exit_code=$(cat "$tmp_norminette_status")

awk '
BEGIN {
    GREEN="\033[32m"
    RED="\033[31m"
    RESET="\033[0m"
}
/OK!$/ { printf GREEN"%s"RESET"\n", $0 }
!/OK!$/ { printf RED"%s"RESET"\n", $0 }
' <"$tmp_norminette_output"

rm "$tmp_norminette_output" "$tmp_norminette_status"

if [ "$norminette_exit_code" -eq 0 ]; then
	printf "%b\n" "\033[32mNorminette check successful for rule '$rule'.\033[0m"
else
	printf "%b\n" "\033[31mNorminette check found issues for rule '$rule'.\033[0m"
	exit 1
fi

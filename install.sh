#!/bin/sh

INSTALL_DIR="$HOME/.local/bin"
SCRIPTS_DIR="./scripts"

printf "%b\n" "\033[34mStarting installation of 42-utils...\033[0m"

if [ ! -d "$SCRIPTS_DIR" ]; then
	printf "%b\n" "\033[31mError: \033[0mScripts directory '$SCRIPTS_DIR' not found."
	printf "%b\n" "\033[31mPlease run this script from the root of your 42-utils folder.\033[0m"
	exit 1
fi

if [ ! -d "$INSTALL_DIR" ]; then
	printf "%b\n" "\033[33mWarning: \033[0mInstallation directory '$INSTALL_DIR' does not exist. Creating it...\033[0m"
	if ! mkdir -p "$INSTALL_DIR"; then
		printf "%b\n" "\033[31mError: \033[0mFailed to create installation directory '$INSTALL_DIR'.\033[0m"
		exit 1
	fi
fi

printf "%b\n" "\033[34mCopying scripts to '$INSTALL_DIR' and making them executable...\033[0m"
installed_count=0

for script_file in "$SCRIPTS_DIR"/*; do
	if [ -f "$script_file" ]; then
		script_name=$(printf "%s" "$script_file" | sed "s|^.*/||" | sed "s/\.sh$//")
		dest_path="$INSTALL_DIR/$script_name"

		printf "%b\n" "  \033[36mProcessing:\033[0m $script_name"

		if cp "$script_file" "$dest_path"; then
			if chmod +x "$dest_path"; then
				printf "%b\n" "  \033[32mSuccessfully installed:\033[0m $script_name"
				installed_count=$((installed_count + 1))
			else
				printf "%b\n" "\033[31mError: \033[0mFailed to make '$script_name' executable in '$INSTALL_DIR'."
			fi
		else
			printf "%b\n" "\033[31mError: \033[0mFailed to copy '$script_name' to '$INSTALL_DIR'."
		fi
	fi
done

printf "%b\n" "\n\033[32mAll 42-utils scripts installed successfully!\033[0m"
printf "%b\n" "\033[32mTotal scripts installed:\033[0m $installed_count"
printf "%b\n" "\033[33mPlease ensure '$INSTALL_DIR' is in your \$PATH.\033[0m"
printf "%b\n" "\033[33mYou might need to add 'export PATH=\"\$PATH:\$HOME/.local/bin\"' to your ~/.bashrc or ~/.profile.\033[0m"

# 42-utils

Shell utilities used during my piscine at 42 Paris

## Commands

| Command   | Description                                                      | Example Usage            |
|-----------|------------------------------------------------------------------|--------------------------|
| `mkrepos` | Creates numbered directories with a specified prefix             | `mkrepos ex 5`           |
| `rmrepos` | Removes numbered directories with a specified prefix             | `rmrepos ex 5`           |
| `clean`   | Removes all executable files and .o files from current directory | `clean`                  |
| `compile` | Compiles C files with strict flags (-Wall -Wextra -Werror)       | `compile main.c program` |
| `normi`   | Runs norminette with colored output                              | `normi .`                |
| `vg`      | Runs Valgrind with comprehensive memory checking options         | `vg ./program arg1`      |

## Installation

### Quick Install (Recommended)

```bash 
git clone https://github.com/Purpose-Dev/42-utils.git
cd 42-utils
chmod +x install.sh
./install.sh
```

This will install all scripts to `~/.local/bin` and make them globally accessible. Make sure `~/.local/bin` is in your
PATH by adding this to your `~/.bashrc` or `~/.profile`:

```bash
export PATH="PATH:HOME/.local/bin"
``` 

### Manual Install

Make scripts executable and add to your PATH:

```

bash chmod +x *.sh

``` 

## Requirements

- POSIX-compliant shell
- Standard Unix utilities (find, rm, mkdir)
- For specific scripts:
  - `compile`: C compiler (cc/gcc/clang)
  - `normi`: norminette
  - `vg`: valgrind

```

# PasswordUtility

PasswordUtility is a simple Bash script for generating random passwords with customizable length and complexity. You can output the generated password to the console or to a file.

## Features
- Generate random passwords of any length
- Optionally include special characters for complex passwords
- Output password to the console or a file
- Simple command-line interface

### Options
- `-g`                Generate a password
- `-l LENGTH`         Specify password length (default: 12)
- `-c`                Use complex password (with special characters)
- `-o FILE`           Output to file instead of console
- `-h`                Show help message

### Examples

Generate a simple 12-character password:

./PasswordUtility.sh -g


Generate a 16-character complex password:

./PasswordUtility.sh -g -l 16 -c


Generate a password and save it to a file:

./PasswordUtility.sh -g -o mypassword.txt


Show help:

./PasswordUtility.sh -h

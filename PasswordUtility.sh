#!/bin/bash

# Generator of random passwords with lengths of (UserInput) another option of simple or complex password generator
# -g
# -o (output file if specified, otherwise output to console)
# -c

show_help() {
	# Help menu that explains how to use the options
	echo "PasswordUtility.sh - Password Generator and Validator"
	echo ""
	echo "Usage: $0 [OPTIONS]"
	echo "  -g                Generate a password"
	echo "  -l LENGTH         Specify password length (default: 12)"
	echo "  -c                Use complex password (with special characters)"
	echo "  -v PASSWORD       Validate a password for strength"
	echo "  -o FILE           Output to file instead of console"
	echo "  -h                Show this help message"
	echo ""
	echo "Examples:"
	echo "  $0 -g -l 16 -c"
	echo "  $0 -v MyPassword123!"
	echo "  $0 -g -o pass.txt"
}

generate_password() {
	length="$1"
	complex="$2"
	chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	if [ "$complex" = "1" ]; then
		chars+="!@#$%^&*()-_=+[]{};:,.<>?/"
	fi
	password=""
	for ((i=0; i<length; i++)); do
		password+="${chars:RANDOM%${#chars}:1}"
	done
	echo "$password"
}



# Default values
gen=0
length=12
complex=0
output=""
password=""

# Error handling for invalid inputs
# Parse options

# Parse options (no validator)
while getopts ":gl:co:h" opt; do
	case $opt in
		g) gen=1 ;;
		l) length="$OPTARG" ;;
		c) complex=1 ;;
		o) output="$OPTARG" ;;
		h) show_help; exit 0 ;;
		:) echo "Option -$OPTARG requires an argument."; exit 1 ;;
		\?) echo "Invalid option: -$OPTARG"; show_help; exit 1 ;;
	esac
done
shift $((OPTIND-1))


if (( gen )); then
	pass=$(generate_password "$length" "$complex")
	if [ -n "$output" ]; then
		echo "$pass" > "$output"
		echo "Password written to $output"
	else
		echo "$pass"
	fi
	exit 0
fi

show_help
exit 1
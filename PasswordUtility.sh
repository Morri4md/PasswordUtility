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

# Validator of password user enters and checks if it meets the requirements of a strong password (length, uppercase, lowercase, numbers, special characters)
# -v
# -o (output file if specified, otherwise output to console)
validate_password() {
	password="$1"
	length=${#password}
	valid=1
	msg=""
	if (( length < 8 )); then
		msg+="Password too short (min 8).\n"
		valid=0
	fi
	[[ "$password" =~ [A-Z] ]] || { msg+="No uppercase letter.\n"; valid=0; }
	[[ "$password" =~ [a-z] ]] || { msg+="No lowercase letter.\n"; valid=0; }
	[[ "$password" =~ [0-9] ]] || { msg+="No number.\n"; valid=0; }
	[[ "$password" =~ [^a-zA-Z0-9] ]] || { msg+="No special character.\n"; valid=0; }
	if (( valid )); then
		echo "Password is strong."
	else
		echo -e "Password is weak:\n$msg"
	fi
}

# Default values
gen=0
val=0
length=12
complex=0
output=""
password=""

# Error handling for invalid inputs
# Parse options
while getopts ":gvl:co:h" opt; do
	case $opt in
		g) gen=1 ;;
		v) val=1 ;;
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

if (( val )); then
	if [ -n "$1" ]; then
		validate_password "$1"
	else
		echo "No password provided for validation."; exit 1
	fi
	exit 0
fi

show_help
exit 1
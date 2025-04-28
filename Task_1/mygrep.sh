#!/bin/bash

# mygrep.sh: A mini version of grep that searches for a string in a file
# Usage: ./mygrep.sh [-n] [-v] <search_string> <file>
# Options:
#   -n: Show line numbers
#   -v: Invert match (print non-matching lines)
#   --help: Display usage information

# Function to display usage information
usage() {
    echo "Usage: $0 [-n] [-v] <search_string> <file>"
    echo "Options:"
    echo "  -n    Show line numbers for each match"
    echo "  -v    Invert match (print lines that do not match)"
    echo "  --help Display this help message"
    exit 1
}

# Initialize flags
show_line_numbers=false
invert_match=false
search_string=""
file=""

# Parse command-line options using getopts
while getopts "nv" opt; do
    case $opt in
        n) show_line_numbers=true ;;
        v) invert_match=true ;;
        *) usage ;;
    esac
done

# Shift past the options to get positional arguments
shift $((OPTIND - 1))

# Check for --help flag
if [[ "$1" == "--help" ]]; then
    usage
fi

# Assign positional arguments
search_string="$1"
file="$2"

# Validate input
if [[ -z "$search_string" ]]; then
    echo "Error: Search string is required"
    usage
fi

if [[ -z "$file" ]]; then
    echo "Error: File is required"
    usage
fi

if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' does not exist"
    exit 1
fi

# Read the file line by line
line_number=0
while IFS= read -r line; do
    ((line_number++))
    # Perform case-insensitive matching
    if echo "$line" | grep -i -q "$search_string"; then
        # If not inverting, print matching lines
        if ! $invert_match; then
            if $show_line_numbers; then
                echo "$line_number:$line"
            else
                echo "$line"
            fi
        fi
    else
        # If inverting, print non-matching lines
        if $invert_match; then
            if $show_line_numbers; then
                echo "$line_number:$line"
            else
                echo "$line"
            fi
        fi
    fi
done < "$file"

exit 0

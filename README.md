Task 1: mygrep.sh - A Mini grep Clone
mygrep.sh is a Bash script that replicates a simplified version of the grep command. It searches for a string in a text file (case-insensitively) and supports options to show line numbers (-n) and invert matches (-v). Designed to be robust and user-friendly, it handles invalid inputs with clear error messages and includes a --help flag for usage guidance. This script was crafted to feel like a handmade tool, mimicking grep’s output style.
Table of Contents

Features
Installation
Usage
Examples
Testing
Reflective Section
Bonus Features
Contributing
License

Features

Case-Insensitive Search: Matches strings regardless of case (e.g., "hello" matches "HELLO").
Line Numbers (-n): Prefixes matching lines with their line numbers.
Inverted Matching (-v): Outputs lines that do not contain the search string.
Help Flag (--help): Displays usage instructions.
Robust Validation: Checks for missing or invalid arguments/files, with clear errors.
Flexible Options: Uses getopts to handle -n and -v in any order (e.g., -vn, -nv).

Installation

Download the Script:Save mygrep.sh to your desired directory.

Make it Executable:
chmod +x mygrep.sh


Requirements:

Bash (available on most Linux/Unix systems).
No additional dependencies.



Usage
Run the script with:
./mygrep.sh [-n] [-v] <search_string> <file>

Options

-n: Show line numbers for matching lines.
-v: Invert match (show non-matching lines).
--help: Display usage information.

Examples
Using a sample file testfile.txt:
Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three


Basic Search:
./mygrep.sh hello testfile.txt

Output:
Hello world
HELLO AGAIN


With Line Numbers:
./mygrep.sh -n hello testfile.txt

Output:
1:Hello world
4:HELLO AGAIN


Invert Match with Line Numbers:
./mygrep.sh -vn hello testfile.txt

Output:
2:This is a test
3:another test line
5:Don't match this line
6:Testing one two three


Missing Search String:
./mygrep.sh -v testfile.txt

Output:
Error: Search string is required
Usage: ./mygrep.sh [-n] [-v] <search_string> <file>
Options:
  -n    Show line numbers for each match
  -v    Invert match (print lines that do not match)
  --help Display this help message


Missing File:
./mygrep.sh -v hello

Output:
Error: File is required
Usage: ./mygrep.sh [-n] [-v] <search_string> <file>
Options:
  -n    Show line numbers for each match
  -v    Invert match (print lines that do not match)
  --help Display this help message


Help Information:
./mygrep.sh --help

Output:
Usage: ./mygrep.sh [-n] [-v] <search_string> <file>
Options:
  -n    Show line numbers for each match
  -v    Invert match (print lines that do not match)
  --help Display this help message



Testing
To test the script:

Create testfile.txt:
cat << EOF > testfile.txt
Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three
EOF


Run Test Cases:Execute the Examples commands. Screenshots would show:

Matching lines for basic searches.
Line numbers for -n.
Non-matching lines for -v.
Error messages for invalid inputs.



Reflective Section
How the Script Handles Arguments and Options
The script uses getopts to parse -n and -v, setting boolean flags (show_line_numbers, invert_match) for flexible option handling (e.g., -vn or -nv). It shifts past options to access the search string ($1) and file ($2). Validation checks argument count: if fewer than two, it distinguishes between a missing search string (if $1 is a file) or missing file. File existence is verified. Lines are read with a while loop, using grep -i -q for case-insensitive matching. Matching (or non-matching for -v) lines are printed, with line numbers if -n is set. The --help flag shows usage, enhancing usability.
Supporting Regex or -i/-c/-l Options
To add regex or options like -i (case-insensitive toggle), -c (count matches), or -l (list filenames), I’d extend the modular structure. Regex would use grep -E, with syntax validation. The -i option would toggle grep’s -i (currently fixed). For -c, I’d count matches and print the total. For -l, I’d handle multiple files and print matching filenames. This requires updating getopts (getopts "nvicl") and adding output mode logic, keeping validation separate.
Hardest Part to Implement and Why
The trickiest part was input validation, especially handling ./mygrep.sh -v testfile.txt. Early versions misread testfile.txt as the search string. Adding logic to check if $1 is a file (-f "$1") and trigger the right error took debugging. Balancing concise, grep-like errors with robust edge-case handling (e.g., empty files) was like solving a puzzle, but it made the script solid.
Bonus Features

** --help Flag**: Prints usage information for easy onboarding.
** getopts Parsing**: Ensures robust handling of -n and -v, supporting any combination and catching invalid flags.

Contributing
Feel free to fork, modify, or submit pull requests! Ideas for new features (e.g., regex, -i, -c, -l) are welcome. Report issues or suggestions via GitHub (if hosted).
License
This project is unlicensed, free to use and modify as you see fit.

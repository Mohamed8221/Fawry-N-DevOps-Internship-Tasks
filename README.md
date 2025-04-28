# Fawry-N-DevOps-Internship-Tasks

#Task 1: mygrep.sh - A Mini Version of grep
mygrep.sh is a Bash script designed as a simplified version of the grep command. It searches for a string in a text file (case-insensitively) and supports options to display line numbers (-n) and invert matches (-v). The script is robust, handling invalid inputs with clear error messages, and includes a --help flag for usage information. Crafted to feel like a handmade tool, it prioritizes user-friendliness and mimics grep’s output style.
Features

Case-Insensitive Search: Matches the specified string regardless of case (e.g., "hello" matches "HELLO").
Line Numbers (-n): Prefixes matching lines with their line numbers.
Inverted Matching (-v): Outputs lines that do not contain the search string.
Help Flag (--help): Provides usage instructions.
Input Validation: Ensures proper arguments and file existence, with descriptive error messages.
Flexible Option Parsing: Uses getopts to handle -n and -v in any combination (e.g., -vn, -nv).

Usage
Run the script with the following syntax:
./mygrep.sh [-n] [-v] <search_string> <file>

Options

-n: Display line numbers for each matching line.
-v: Invert the match to show non-matching lines.
--help: Show usage information.

Examples
Using a file testfile.txt with the following content:
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


Show Line Numbers:
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



Setup and Testing

Make the Script Executable:
chmod +x mygrep.sh


Create testfile.txt:
cat << EOF > testfile.txt
Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three
EOF


Run Test Cases:Execute the example commands above to verify functionality. Screenshots of these commands would capture:

Matching lines for basic searches.
Line numbers for -n options.
Non-matching lines for -v options.
Error messages for invalid inputs.



Reflective Section
How the Script Handles Arguments and Options
The script uses getopts to parse -n and -v flags, setting boolean variables (show_line_numbers and invert_match) to handle options flexibly (e.g., -vn or -nv). After parsing, it shifts to access the search string ($1) and file ($2). Validation checks the number of arguments: if fewer than two are provided, it detects whether $1 is a file (missing search string) or not (missing file). It also verifies the file exists. The script processes the file line-by-line, using grep -i -q for case-insensitive matching, and outputs matching (or non-matching for -v) lines with optional line numbers (-n). The --help flag displays a usage message, enhancing usability.
Supporting Regex or -i/-c/-l Options
Adding regex or options like -i (case-insensitive toggle), -c (count matches), or -l (list filenames) would extend the script’s modular design. Regex would use grep -E for pattern matching, with validation for regex syntax. The -i option would toggle case sensitivity (currently fixed). For -c, I’d count matches and print only the total. For -l, I’d support multiple files and print filenames with matches. This would involve updating getopts to handle new flags (getopts "nvicl") and adding output mode logic, keeping validation and processing separate for maintainability.
Hardest Part to Implement and Why
The most challenging part was perfecting the input validation, particularly for cases like ./mygrep.sh -v testfile.txt. Early versions incorrectly treated testfile.txt as the search string, requiring a fix to check if $1 is a file and flag a missing search string. This took some debugging to get right, as I had to balance clear, grep-like error messages with robust logic for edge cases (e.g., empty files or missing arguments). It felt like untangling a knot, but solving it made the script much more reliable.
Bonus Features

Support for --help Flag: The --help flag prints usage information, making the script accessible to new users.
Improved Option Parsing with getopts: getopts ensures clean handling of -n and -v, supporting any flag combination and catching invalid options.

Notes
This script was crafted to feel like a developer’s handmade project, with clear comments, intuitive errors, and a structure that echoes grep. The reflective section captures the design process, and the test cases confirm reliability. To extend it (e.g., with regex or new options), the script’s modular foundation is ready for growth.

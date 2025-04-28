# mygrep.sh - A Mini Version of `grep`

`mygrep.sh` is a Bash script designed as a simplified version of the `grep` command.\
It searches for a string in a text file (case-insensitively) and supports options to display line numbers (`-n`) and invert matches (`-v`).\
The script is robust, handling invalid inputs with clear error messages, and includes a `--help` flag for usage information.

Crafted to feel like a handmade developer tool, it prioritizes user-friendliness and mimics `grep`’s output style.

---

## Features

- **Case-Insensitive Search**: Matches the specified string regardless of case (e.g., `"hello"` matches `"HELLO"`).
- **Line Numbers (****`-n`****)**: Prefixes matching lines with their line numbers.
- **Inverted Matching (****`-v`****)**: Outputs lines that do not contain the search string.
- **Help Flag (****`--help`****)**: Displays usage instructions.
- **Input Validation**: Ensures proper arguments and file existence, with descriptive error messages.
- **Flexible Option Parsing**: Uses `getopts` to handle `-n` and `-v` in any combination (e.g., `-vn`, `-nv`).

---

## Usage

```bash
./mygrep.sh [-n] [-v] <search_string> <file>
```

### Options

| Option   | Description                               |
| -------- | ----------------------------------------- |
| `-n`     | Show line numbers for each matching line. |
| `-v`     | Invert match (print non-matching lines).  |
| `--help` | Display help/usage information.           |

---

## Examples

Given a `testfile.txt` with the following content:

```
Hello world
This is a test
another test line
HELLO AGAIN
Don't match this line
Testing one two three
```

### Basic Search

```bash
./mygrep.sh hello testfile.txt
```

**Output:**

```
Hello world
HELLO AGAIN
```

### Show Line Numbers

```bash
./mygrep.sh -n hello testfile.txt
```

**Output:**

```
1:Hello world
4:HELLO AGAIN
```

### Invert Match with Line Numbers

```bash
./mygrep.sh -vn hello testfile.txt
```

**Output:**

```
2:This is a test
3:another test line
5:Don't match this line
6:Testing one two three
```

---

## Error Handling

### Missing Search String

```bash
./mygrep.sh -v testfile.txt
```

**Output:**

```
Error: Search string is required
Usage: ./mygrep.sh [-n] [-v] <search_string> <file>
Options:
  -n      Show line numbers for each match
  -v      Invert match (print lines that do not match)
  --help  Display this help message
```

### Missing File

```bash
./mygrep.sh -v hello
```

**Output:**

```
Error: File is required
Usage: ./mygrep.sh [-n] [-v] <search_string> <file>
Options:
  -n      Show line numbers for each match
  -v      Invert match (print lines that do not match)
  --help  Display this help message
```

### Help Information

```bash
./mygrep.sh --help
```

**Output:**

```
Usage: ./mygrep.sh [-n] [-v] <search_string> <file>
Options:
  -n      Show line numbers for each match
  -v      Invert match (print lines that do not match)
  --help  Display this help message
```

---

## Setup and Testing

1. **Make the script executable:**

   ```bash
   chmod +x mygrep.sh
   ```

2. **Create a test file:**

   ```bash
   cat << EOF > testfile.txt
   Hello world
   This is a test
   another test line
   HELLO AGAIN
   Don't match this line
   Testing one two three
   EOF
   ```

3. **Run Test Cases:**\
   Execute the example commands above to verify functionality.\
   You can also capture screenshots showing:

   - Matching lines for basic searches.
   - Line numbers for `-n` option.
   - Non-matching lines for `-v` option.
   - Error messages for invalid inputs.

---

## Reflective Section

### How the Script Handles Arguments and Options

- The script uses `getopts` to parse `-n` and `-v` flags, setting boolean variables (`show_line_numbers` and `invert_match`).
- After parsing, it shifts to access the search string (`$1`) and the file (`$2`).
- Input validation ensures:
  - Correct number of arguments.
  - Proper distinction between missing search string and missing file.
  - File existence check.
- File processing is line-by-line using `grep -i -q` for case-insensitive matching.
- Matching (or non-matching) lines are output with optional line numbers (`-n`).
- The `--help` flag displays usage instructions.

### Supporting Regex or Additional Options (`-i`, `-c`, `-l`)

Possible extensions:

- **Regex Matching**: Use `grep -E` for extended patterns.
- **`-i`**** Flag**: Toggle case sensitivity dynamically (currently always case-insensitive).
- **`-c`**** Flag**: Count and output only the number of matches.
- **`-l`**** Flag**: List filenames with matches across multiple files.

These additions would involve expanding `getopts` (e.g., `getopts "nvicl"`) and modularizing output logic further.

---

## Challenges Faced

The most challenging part was perfecting input validation, especially detecting when the search string was missing versus when the file was missing (e.g., in `./mygrep.sh -v testfile.txt`).\
Early versions misinterpreted arguments, requiring careful logic to distinguish cases and maintain grep-like behavior.

Solving this significantly improved the script’s reliability and made the error messages clear and professional.

---

## Bonus Features

- **Support for ****`--help`**: Making it easier for new users to understand the script quickly.
- **Improved Option Parsing**: Using `getopts` for clean, flexible handling of multiple flag combinations and invalid inputs.



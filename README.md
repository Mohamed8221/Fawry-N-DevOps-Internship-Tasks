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

---

# Task 2: Verify DNS Resolution

To diagnose why `internal.example.com` is unreachable with "host not found" errors, we first verify DNS resolution. The goal is to compare how the system’s configured DNS server (from `/etc/resolv.conf`) resolves the hostname versus a public DNS server like `8.8.8.8`.

## Steps to Verify DNS Resolution

### Check the Current DNS Configuration
View the DNS servers configured in `/etc/resolv.conf`:
```bash
cat /etc/resolv.conf
```

**Expected Output:**
```
nameserver 192.168.1.1
nameserver 192.168.1.2
```

This shows the system is using internal DNS servers.

> **Screenshot Note:** Capture the output of `cat /etc/resolv.conf` to document the configured DNS servers.

---

### Test DNS Resolution Using System DNS
Use `dig` to query `internal.example.com` using the system’s default DNS servers:
```bash
dig internal.example.com
```

**Expected Output (if resolution fails):**
```
;; QUESTION SECTION:
;internal.example.com.          IN      A

;; AUTHORITY SECTION:
example.com.            3600    IN      SOA     ns1.example.com. hostmaster.example.com. (
                                        2025042701 ; serial
                                        7200       ; refresh
                                        3600       ; retry
                                        1209600    ; expire
                                        3600       ; minimum
                                        )
;; Query time: 50 msec
;; SERVER: 192.168.1.1#53(192.168.1.1)
```

If no ANSWER SECTION appears, the DNS server cannot resolve `internal.example.com`.

> **Screenshot Note:** Capture the `dig` output to show whether an IP address was returned or if the query failed.

---

### Test DNS Resolution Using Google’s DNS (8.8.8.8)
Explicitly query `8.8.8.8` to see if the public DNS resolves the hostname:
```bash
dig @8.8.8.8 internal.example.com
```

**Expected Output (likely fails for internal hostname):**
```
;; QUESTION SECTION:
;internal.example.com.          IN      A

;; AUTHORITY SECTION:
example.com.            3600    IN      SOA     ns1.example.com. hostmaster.example.com. (
                                        2025042701 ; serial
                                        7200       ; refresh
                                        3600       ; retry
                                        1209600    ; expire
                                        3600       ; minimum
                                        )
;; Query time: 30 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
```

Since `internal.example.com` is likely an internal hostname, `8.8.8.8` probably won’t resolve it.

> **Screenshot Note:** Capture this `dig` output to compare with the system DNS result.

---

### Alternative: Use `nslookup` for Simplicity
If `dig` is unavailable, use `nslookup`:
```bash
nslookup internal.example.com
nslookup internal.example.com 8.8.8.8
```

**Expected Output (if resolution fails):**
```
Server:         192.168.1.1
Address:        192.168.1.1#53

** server can't find internal.example.com: NXDOMAIN
```

> **Screenshot Note:** Capture `nslookup` outputs for both queries.

---

## Analysis

- If the system’s DNS (`192.168.1.1`) fails to resolve `internal.example.com` but is expected to, the internal DNS server may be misconfigured or down.
- If `8.8.8.8` fails (as expected for an internal hostname), this is normal behavior.
- If both fail and you know `internal.example.com` should resolve internally, the issue lies with the internal DNS server or client configuration.

## Next Steps

- If DNS resolution fails, we’ll explore potential DNS-related causes in **Task 3**.
- If resolution succeeds (e.g., returns `192.168.1.100`), proceed to check service reachability.



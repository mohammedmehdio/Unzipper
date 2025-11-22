# 📂 Unzipper

**Unzipper** is a robust Bash automation script designed to ruthlessly peel back multiple layers of file compression.

I created this tool to solve **Level 12 of the OverTheWire Bandit wargame**, where the flag is hidden inside a "Russian Nesting Doll" of files—a file inside a tarball, inside a gzip, inside a bzip2, inside a hexdump.

## 🚀 Why Unzipper?

Manual decompression is slow. You have to run `file`, rename the extension, and run the correct extraction command over and over again.

**Unzipper** turns a tedious 15-minute manual process into a **1-second** automated task. It doesn't care how many layers there are; it keeps digging until it hits plain text.

## ✨ Key Features

* **Hexdump Reversal:** Automatically detects if the starting file is a hexdump and converts it back to binary using `xxd`.
* **Multi-Format Support:** Handles `gzip`, `bzip2`, and `tar` archives seamlessly.
* **Smart Tar Extraction:** Uses `tar -tf` to "peek" inside archives before extracting. This prevents the script from crashing or grabbing the wrong file in the directory.
* **Infinite Loop Logic:** Continues processing recursively until `ASCII text` is detected.

## 🛠️ Prerequisites

This script runs on any standard Linux environment (Ubuntu, Kali, Debian, MacOS) with the following utilities:
* `bash`
* `file`
* `xxd`
* `tar`
* `gzip`
* `bzip2`

## 📥 Installation & Usage

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/mohammedmehdio/Unzipper/unzipper.sh
    cd Unzipper
    ```

2.  **Make the script executable:**
    ```bash
    chmod +x unzipper.sh
    ```

3.  **Run The Unzipper on your target file:**
    ```bash
    ./unzipper.sh data.txt
    ```

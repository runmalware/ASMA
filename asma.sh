#!/bin/bash

# Print ASCII art to terminal
echo "    _   ___ __  __   _   "
echo "   /_\ / __|  \/  | /_\  "
echo "  / _ \\__ \ |\/| |/ _ \ "
echo " /_/ \_\___/_|  |_/_/ \_\\"
echo ""
echo "Automatation tool for Malware Static Analysis based on Linux"
echo "original repo : https://github.com/runmalware/ASMA"


# Function to check and install required tools
check_and_install_tools() {
    tools=("file" "strings" "pev" "exiftool" "yara" "sha3sum")
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            echo "$tool is not installed. Do you want to install it? (yes/no)"
            read -r install
            if [ "$install" == "yes" ]; then
                sudo apt-get install -y "$tool"
            else
                echo "$tool is required for this script to run. Exiting."
                exit 1
            fi
        fi
    done
}

# Check and install required tools
check_and_install_tools

# Prompt for malware filename
echo "Enter the path to the malware file:"
read -r malware_file

# Check if file exists
if [ ! -f "$malware_file" ]; then
    echo "File does not exist. Exiting."
    exit 1
fi

# Prompt for output filename
echo "Enter the path to the output file:"
read -r output_file

# Calculate and print file hashes
echo "File Hashes:" > "$output_file"
md5sum "$malware_file" | awk '{print "MD5: "$1}' >> "$output_file"
sha1sum "$malware_file" | awk '{print "SHA1: "$1}' >> "$output_file"
sha256sum "$malware_file" | awk '{print "SHA256: "$1}' >> "$output_file"
sha3sum -a 512 "$malware_file" | awk '{print "SHA3-512: "$1}' >> "$output_file"
echo "" >> "$output_file"

# Basic file information
echo "Basic File Information:" >> "$output_file"
file "$malware_file" >> "$output_file"
echo "" >> "$output_file"

# Static analysis with strings
echo "Strings Analysis:" >> "$output_file"
strings -a "$malware_file" >> "$output_file"
echo "" >> "$output_file"

# Extracting PE headers if applicable
if file "$malware_file" | grep -q "PE32 executable"; then
    echo "PE Headers Analysis:" >> "$output_file"
    pev -v "$malware_file" >> "$output_file"
    echo "" >> "$output_file"
fi

# Extracting metadata if applicable
if [ -x "$(command -v exiftool)" ]; then
    echo "Metadata Analysis:" >> "$output_file"
    exiftool "$malware_file" >> "$output_file"
    echo "" >> "$output_file"
fi

# Running YARA rules from VirusTotal YARA repository
if [ -x "$(command -v yara)" ]; then
    echo "YARA Analysis:" >> "$output_file"
    yara /path/to/virustotal/yara/rules/* "$malware_file" >> "$output_file"  # Replace with actual path to VirusTotal YARA rules
    echo "" >> "$output_file"
fi

# Other analysis commands can be added here as needed

# End of script

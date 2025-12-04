#!/bin/bash
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to check if a command exists
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "\033[0;31mError: $1 is not installed\033[0m"
        if [ "$1" = "jq" ]; then
            if command -v brew &> /dev/null; then
                echo -e "\033[0;33mInstalling jq using Homebrew...\033[0m"
                brew install jq
            else
                echo -e "\033[0;31mPlease install jq first: https://stedolan.github.io/jq/\033[0m"
                exit 1
            fi
        else
            echo -e "\033[0;31mPlease install $1 first\033[0m"
            exit 1
        fi
    fi
}

# Check for required commands
check_command "curl"
check_command "jq"

# GitHub API base URL
GITHUB_API="https://api.github.com/repos/chand1012/cursorrules/contents"

# Function to fetch and download files from a directory
download_from_path() {
    local path=$1
    local files=$(curl -s "$GITHUB_API/$path" | jq -r '.[].name')
    
    for file in $files; do
        echo -e "\033[0;183mDownloading: $file\033[0m"
        curl -s "https://raw.githubusercontent.com/chand1012/cursorrules/main/$path/$file" > ".cursor/rules/$file"
    done
}

echo -e "\033[0;147mFetching and installing all rules...\033[0m"

# Create necessary directories
mkdir -p .cursor/rules/

# Download all items
download_from_path "frameworks"
download_from_path "languages"
download_from_path "practice"

echo -e "\033[1;0;183mInstallation complete!\033[0m"
echo -e "\033[0;147mAll rules have been installed to ./.cursor/rules/\033[0m"

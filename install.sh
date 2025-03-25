#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a command exists
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}Error: $1 is not installed${NC}"
        if [ "$1" = "gum" ]; then
            if command -v brew &> /dev/null; then
                echo "Installing gum using Homebrew..."
                brew install gum
            else
                echo "Please install gum first: https://smolurl.cc/tPJ0JQ"
                exit 1
            fi
        else
            echo "Please install $1 first"
            exit 1
        fi
    fi
}

# Check for required commands
check_command "gum"
check_command "curl"
check_command "jq"

# GitHub API base URL
GITHUB_API="https://api.github.com/repos/chandlerh/llmrules/contents"

# Function to fetch and format options from GitHub
fetch_options() {
    local path=$1
    local response=$(curl -s "$GITHUB_API/$path")
    
    # Check if the response is valid JSON
    if ! echo "$response" | jq . >/dev/null 2>&1; then
        echo -e "${RED}Error: Failed to fetch $path from GitHub API${NC}"
        echo -e "${YELLOW}Response: $response${NC}"
        return 1
    fi
    
    # Extract names and filter out README.md
    echo "$response" | jq -r '.[].name' | grep -v "README.md"
}

# Fetch available options
echo "Fetching available options..."

# Fetch and store options in arrays
mapfile -t FRAMEWORKS < <(fetch_options "frameworks")
mapfile -t LANGUAGES < <(fetch_options "languages")
mapfile -t PRACTICES < <(fetch_options "practice")

# Check if we got any options
if [ ${#FRAMEWORKS[@]} -eq 0 ] && [ ${#LANGUAGES[@]} -eq 0 ] && [ ${#PRACTICES[@]} -eq 0 ]; then
    echo -e "${RED}Error: No options found. Please check your internet connection and try again.${NC}"
    exit 1
fi

# Create selection menus
echo -e "${GREEN}Welcome to LLM Rules Installer!${NC}"
echo "Please select the options you want to install:"

# Framework selection
if [ ${#FRAMEWORKS[@]} -gt 0 ]; then
    echo -e "\n${GREEN}Select Frameworks:${NC}"
    FRAMEWORK_CHOICES=$(gum choose --no-limit "${FRAMEWORKS[@]}")
fi

# Language selection
if [ ${#LANGUAGES[@]} -gt 0 ]; then
    echo -e "\n${GREEN}Select Languages:${NC}"
    LANGUAGE_CHOICES=$(gum choose --no-limit "${LANGUAGES[@]}")
fi

# Practice selection
if [ ${#PRACTICES[@]} -gt 0 ]; then
    echo -e "\n${GREEN}Select Practices:${NC}"
    PRACTICE_CHOICES=$(gum choose --no-limit "${PRACTICES[@]}")
fi

# Check if any choices were made
if [ -z "$FRAMEWORK_CHOICES" ] && [ -z "$LANGUAGE_CHOICES" ] && [ -z "$PRACTICE_CHOICES" ]; then
    echo -e "${YELLOW}No options were selected. Exiting...${NC}"
    exit 0
fi

# Confirm installation
echo -e "\n${GREEN}Selected Options:${NC}"
[ ! -z "$FRAMEWORK_CHOICES" ] && echo "Frameworks: $FRAMEWORK_CHOICES"
[ ! -z "$LANGUAGE_CHOICES" ] && echo "Languages: $LANGUAGE_CHOICES"
[ ! -z "$PRACTICE_CHOICES" ] && echo "Practices: $PRACTICE_CHOICES"

if gum confirm "Proceed with installation?"; then
    # Create necessary directories
    mkdir -p ./.cursor/rules/

    # Download selected items
    for framework in $FRAMEWORK_CHOICES; do
        echo "Downloading framework: $framework"
        curl -s "https://raw.githubusercontent.com/chandlerh/llmrules/main/frameworks/$framework" > ./.cursor/rules/$framework
    done

    for language in $LANGUAGE_CHOICES; do
        echo "Downloading language: $language"
        curl -s "https://raw.githubusercontent.com/chandlerh/llmrules/main/languages/$language" > ./.cursor/rules/$language
    done

    for practice in $PRACTICE_CHOICES; do
        echo "Downloading practice: $practice"
        curl -s "https://raw.githubusercontent.com/chandlerh/llmrules/main/practice/$practice" > ./.cursor/rules/$practice
    done

    echo -e "${GREEN}Installation complete!${NC}"
    echo "Files have been installed to ./.cursor/rules/"
else
    echo "Installation cancelled."
    exit 1
fi 

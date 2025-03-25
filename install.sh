#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
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
        elif [ "$1" = "jq" ]; then
            if command -v brew &> /dev/null; then
                echo "Installing jq using Homebrew..."
                brew install jq
            else
                echo "Please install jq first: https://stedolan.github.io/jq/"
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
GITHUB_API="https://api.github.com/repos/chand1012/llmrules/contents"

# Function to fetch and format options from GitHub
fetch_options() {
    local path=$1
    curl -s "$GITHUB_API/$path" | jq -r '.[].name'
}

# Fetch available options
echo "Fetching available options..."
FRAMEWORKS=($(fetch_options "frameworks"))
LANGUAGES=($(fetch_options "languages"))
PRACTICES=($(fetch_options "practice"))

# Create selection menus
echo "Welcome to LLM Rules Installer!"
echo "Please select the options you want to install:"


# Language selection
echo -e "\n${GREEN}Select Languages:${NC}"
LANGUAGE_CHOICES=$(gum choose --no-limit "${LANGUAGES[@]}")

# Framework selection
echo -e "\n${GREEN}Select Frameworks:${NC}"
FRAMEWORK_CHOICES=$(gum choose --no-limit "${FRAMEWORKS[@]}")

# Practice selection
echo -e "\n${GREEN}Select Practices:${NC}"
PRACTICE_CHOICES=$(gum choose --no-limit "${PRACTICES[@]}")

# Confirm installation
echo -e "\n${GREEN}Selected Options:${NC}"
echo "Frameworks: $FRAMEWORK_CHOICES"
echo "Languages: $LANGUAGE_CHOICES"
echo "Practices: $PRACTICE_CHOICES"

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

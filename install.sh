#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to check if a command exists
check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "\033[0;31mError: $1 is not installed\033[0m"
        if [ "$1" = "gum" ]; then
            if command -v brew &> /dev/null; then
                echo -e "\033[0;33mInstalling gum using Homebrew...\033[0m"
                brew install gum
            else
                echo -e "\033[0;31mPlease install gum first: https://smolurl.cc/tPJ0JQ\033[0m"
                exit 1
            fi
        elif [ "$1" = "jq" ]; then
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
check_command "gum"
check_command "curl"
check_command "jq"

# GitHub API base URL
GITHUB_API="https://api.github.com/repos/chand1012/cursorrules/contents"

# Function to fetch and format options from GitHub
fetch_options() {
    local path=$1
    curl -s "$GITHUB_API/$path" | jq -r '.[].name'
}

gum style --foreground 147 "Fetching available options..."
FRAMEWORKS=($(fetch_options "frameworks"))
LANGUAGES=($(fetch_options "languages"))
PRACTICES=($(fetch_options "practice"))

# Create selection menus
gum style \
    --border double \
    --border-foreground 219 \
    --padding 1 \
    --margin 1 \
    --bold \
    --foreground 219 \
    "╭──────────────────────────────────────╮" \
    "│         LLM Rules Installer          │" \
    "╰──────────────────────────────────────╯"

gum style --foreground 147 "Please select the options you want to install:"

# Language selection
gum style --bold --foreground 183 "Select Languages:"
LANGUAGE_CHOICES=$(gum choose --no-limit "${LANGUAGES[@]}")

# Framework selection
gum style --bold --foreground 183 "Select Frameworks:"
FRAMEWORK_CHOICES=$(gum choose --no-limit "${FRAMEWORKS[@]}")

# Practice selection
gum style --bold --foreground 183 "Select Practices:"
PRACTICE_CHOICES=$(gum choose --no-limit "${PRACTICES[@]}")

# Confirm installation
gum style --bold --foreground 219 "Selected Options:"
echo -n "Frameworks: " && gum style --foreground 178 "${FRAMEWORK_CHOICES[*]}"
echo -n "Languages: " && gum style --foreground 178 "${LANGUAGE_CHOICES[*]}"
echo -n "Practices: " && gum style --foreground 178 "${PRACTICE_CHOICES[*]}"

if gum confirm "Proceed with installation?"; then
    # Create necessary directories
    mkdir -p .cursor/rules/

    # Download selected items
    for framework in $FRAMEWORK_CHOICES; do
        gum style --foreground 183 "Downloading framework: $framework"
        curl -s "https://raw.githubusercontent.com/chand1012/cursorrules/main/frameworks/$framework" > .cursor/rules/$framework
    done

    for language in $LANGUAGE_CHOICES; do
        gum style --foreground 183 "Downloading language: $language"
        curl -s "https://raw.githubusercontent.com/chand1012/cursorrules/main/languages/$language" > .cursor/rules/$language
    done

    for practice in $PRACTICE_CHOICES; do
        gum style --foreground 183 "Downloading practice: $practice"
        curl -s "https://raw.githubusercontent.com/chand1012/cursorrules/main/practice/$practice" > .cursor/rules/$practice
    done

    gum style --bold --foreground 183 "Installation complete!"
    gum style --foreground 147 "Files have been installed to ./.cursor/rules/"

    # Ask if user wants to convert to OpenHands format
    if gum confirm "Would you like to convert these rules to OpenHands format?"; then
        gum style --foreground 147 "Converting rules to OpenHands format..."
        
        # Create .openhands/microagents directory if it doesn't exist
        mkdir -p .openhands/microagents

        # Create repo.md with the header
        cat > .openhands/microagents/repo.md << 'EOF'
---
name: repo
type: repo
agent: CodeActAgent
---

EOF

        # Process each .mdc file in .cursor/rules
        for file in .cursor/rules/*.mdc; do
            if [ -f "$file" ]; then
                gum style --foreground 178 "Converting: $(basename "$file")"
                # Remove YAML frontmatter (content between first two '---' lines) and append to repo.md
                awk '
                    BEGIN {in_frontmatter=0; first_marker=0}
                    /^---$/ {
                        if (first_marker == 0) {
                            first_marker=1;
                            in_frontmatter=1;
                            next;
                        } else if (in_frontmatter) {
                            in_frontmatter=0;
                            next;
                        }
                    }
                    !in_frontmatter {print}
                ' "$file" >> .openhands/microagents/repo.md
                
                # Add a newline between files
                echo "" >> .openhands/microagents/repo.md
            fi
        done

        gum style --bold --foreground 183 "OpenHands conversion complete!"
        gum style --foreground 147 "Converted rules are available in .openhands/microagents/repo.md"
    fi
else
    gum style --foreground 204 "Installation cancelled."
    exit 1
fi 

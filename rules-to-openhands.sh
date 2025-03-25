#!/bin/bash

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

# Make the script executable
chmod +x rules-to-openhands.sh

echo "Conversion complete! Check .openhands/microagents/repo.md for the result." 

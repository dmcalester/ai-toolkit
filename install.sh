#!/bin/bash

# Gravity Well Toolkit Installer

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Installing Gravity Well Toolkit..."

# Create directories
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/meta"
mkdir -p "$CLAUDE_DIR/logs"

# Copy commands
echo "  Installing commands..."
cp -r "$SCRIPT_DIR/commands/"* "$CLAUDE_DIR/commands/"

# Copy skills
echo "  Installing skills..."
cp -r "$SCRIPT_DIR/skills/"* "$CLAUDE_DIR/skills/"

# Copy meta files (don't overwrite existing priorities/backlog)
echo "  Installing meta files..."
cp "$SCRIPT_DIR/meta/patterns.md" "$CLAUDE_DIR/meta/"

if [ ! -f "$CLAUDE_DIR/meta/priorities.md" ]; then
    cp "$SCRIPT_DIR/meta/priorities.template.md" "$CLAUDE_DIR/meta/priorities.md"
    echo "  Created priorities.md from template"
else
    echo "  Keeping existing priorities.md"
fi

if [ ! -f "$CLAUDE_DIR/meta/backlog.md" ]; then
    cp "$SCRIPT_DIR/meta/backlog.template.md" "$CLAUDE_DIR/meta/backlog.md"
    echo "  Created backlog.md from template"
else
    echo "  Keeping existing backlog.md"
fi

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Restart Claude Code to load skills"
echo "  2. Edit your priorities: ~/.claude/meta/priorities.md"
echo "  3. Try: /focus"
echo ""

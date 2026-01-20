#!/bin/bash

# Gravity Well Toolkit Uninstaller

CLAUDE_DIR="$HOME/.claude"

echo "Uninstalling Gravity Well Toolkit..."

# Remove commands
rm -f "$CLAUDE_DIR/commands/focus.md"
rm -f "$CLAUDE_DIR/commands/observe.md"
rm -f "$CLAUDE_DIR/commands/backlog.md"

# Remove skills
rm -rf "$CLAUDE_DIR/skills/gravity-well"
rm -rf "$CLAUDE_DIR/skills/session-observer"

# Remove meta files (keep user data)
rm -f "$CLAUDE_DIR/meta/patterns.md"

echo ""
echo "Uninstalled commands and skills."
echo ""
echo "Kept your data:"
echo "  ~/.claude/meta/priorities.md"
echo "  ~/.claude/meta/backlog.md"
echo "  ~/.claude/logs/"
echo ""
echo "Delete these manually if you want to remove everything."
echo ""

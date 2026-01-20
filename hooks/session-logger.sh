#!/bin/bash
# Automatic session logger using Apple's on-device Foundation Model
# Triggered by Claude Code's SessionEnd hook

# Debug log
DEBUG_LOG="${HOME}/.claude/logs/session-logger-debug.log"
mkdir -p "$(dirname "$DEBUG_LOG")"
echo "=== $(date) ===" >> "$DEBUG_LOG"
echo "Script started" >> "$DEBUG_LOG"

# Read hook input from stdin immediately and store it
# This must happen before any other commands that might read stdin
HOOK_INPUT=""
if [[ ! -t 0 ]]; then
    HOOK_INPUT=$(cat)
fi

# Exit silently if no input
if [[ -z "$HOOK_INPUT" ]]; then
    echo "No input received" >> "$DEBUG_LOG"
    exit 0
fi
echo "Input received: ${#HOOK_INPUT} chars" >> "$DEBUG_LOG"

# Only run on SessionEnd events
EVENT=$(echo "$HOOK_INPUT" | jq -r '.hook_event_name // empty' 2>/dev/null)
echo "Event: $EVENT" >> "$DEBUG_LOG"
if [[ "$EVENT" != "SessionEnd" ]]; then
    echo "Not SessionEnd, exiting" >> "$DEBUG_LOG"
    exit 0
fi

# Extract transcript path
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | jq -r '.transcript_path // empty' 2>/dev/null)
echo "Transcript: $TRANSCRIPT_PATH" >> "$DEBUG_LOG"
if [[ -z "$TRANSCRIPT_PATH" || ! -f "$TRANSCRIPT_PATH" ]]; then
    echo "Transcript not found, exiting" >> "$DEBUG_LOG"
    exit 0
fi

# Setup
DATE=$(date +%Y-%m-%d)
LOG_DIR="${HOME}/.claude/logs"
LOG_FILE="${LOG_DIR}/${DATE}-session.md"
mkdir -p "$LOG_DIR"

# Extract conversation content from JSONL transcript
CONVERSATION=$(jq -r '
    select(.type == "user" or .type == "assistant") |
    if .type == "user" then
        "USER: " + (.message.content // "")
    else
        "ASSISTANT: " + (
            if (.message.content | type) == "array" then
                (.message.content | map(select(.type == "text") | .text) | join(" "))
            else
                (.message.content // "")
            end
        )
    end
' "$TRANSCRIPT_PATH" 2>/dev/null)

# Truncate to reasonable size for the on-device model
CONVERSATION="${CONVERSATION:0:12000}"

# Skip if conversation is too short
echo "Conversation length: ${#CONVERSATION}" >> "$DEBUG_LOG"
if [[ ${#CONVERSATION} -lt 500 ]]; then
    echo "Too short, exiting" >> "$DEBUG_LOG"
    exit 0
fi

# Get project context
CWD=$(echo "$HOOK_INPUT" | jq -r '.cwd // "unknown"' 2>/dev/null)
PROJECT_NAME=$(basename "$CWD" 2>/dev/null || echo "unknown")

# Generate session log using Apple's on-device model
PROMPT="Analyze this coding session for focus and attention patterns. Generate a brief session log.

SESSION TRANSCRIPT:
${CONVERSATION}

OUTPUT FORMAT (use exactly this structure):
## Session: ${DATE} - ${PROJECT_NAME}

### Goal
[One sentence: what the user was trying to accomplish]

### Summary
- **Accomplished**: [What got done]
- **Stopped at**: [Where things ended]

### Pivots
[List any topic/approach changes, or 'None' if stayed focused]

### Patterns Noticed
[Any attention patterns: shiny object syndrome, rabbit holes, almost-done, complexity creep, etc. Or 'None obvious']

Be concise. Output ONLY the formatted log, nothing else."

echo "Calling afm..." >> "$DEBUG_LOG"
SESSION_LOG=$(afm -s "$PROMPT" 2>&1)
echo "afm returned: ${#SESSION_LOG} chars" >> "$DEBUG_LOG"

# Append to daily log file
if [[ -n "$SESSION_LOG" ]]; then
    echo "Writing to $LOG_FILE" >> "$DEBUG_LOG"
    {
        echo ""
        echo "$SESSION_LOG"
        echo ""
        echo "---"
    } >> "$LOG_FILE"
fi

exit 0

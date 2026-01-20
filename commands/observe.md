---
description: Analyze session logs for focus and attention patterns
argument-hint: [today|yesterday|week|YYYY-MM-DD]
---

Analyze work session logs for focus and attention patterns.

## Scope
- No argument or "today": Analyze today's session
- "yesterday": Analyze yesterday's session
- "week": Cross-session analysis for past 7 days
- Specific date: Analyze that date's session

## Log Locations

Check for logs in order:
1. Project: `./logs/YYYY-MM-DD-session.md`
2. Global: `~/.claude/logs/YYYY-MM-DD-session.md`

## Instructions

1. Read `~/.claude/meta/patterns.md` for pattern definitions (fallback to project `meta/patterns.md`)
2. Read the relevant session log(s)
3. Analyze for patterns defined in the observer doc
4. Provide assessment in this format:

```
## Session: [date]

### What Happened
[Brief factual summary]

### Patterns Observed
- **[Pattern Name]**: [Evidence from session]

### Wins
[What went well, finished tasks, good decisions]

### Watch For
[Patterns to be aware of, not criticisms]

### Suggestion
[One concrete thing to try next time]
```

## Tone
- Observational, not critical
- ADHD patterns aren't character flaws
- Highlight strengths too
- Keep suggestions minimal and actionable

Arguments: $ARGUMENTS

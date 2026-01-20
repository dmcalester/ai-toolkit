---
name: session-observer
description: Use when the user seems to be ending a session, feeling frustrated, stuck, or scattered. Triggers on phrases like "let's stop", "I'm done", "this isn't working", "I need a break", "I'm tired", "let's wrap up", or when significant context switches or pivots happen. Helps track focus and attention patterns.
---

# Session Observer

A session observer that helps track work patterns without judgment.

## When to Activate

- User signals session end ("let's stop", "I'm done", "wrapping up")
- User expresses frustration ("this isn't working", "I'm stuck")
- User requests a break or seems fatigued
- Multiple pivots or context switches in conversation
- User asks about patterns or how the session went

## What to Do

### At Session End
1. Offer to create/update session log
2. Note accomplishments vs intentions
3. Note any pivots that occurred
4. Ask one optional reflection question

### Log Location
- Prefer project log: `./logs/YYYY-MM-DD-session.md`
- Fallback to global: `~/.claude/logs/YYYY-MM-DD-session.md`
- Create directory if needed

### Mid-Session Pattern Notices
- Gently note if working solution being abandoned
- Point out scope expansion beyond original goal
- Don't interrupt productive flow

## Session Log Format

```markdown
# Session Log: YYYY-MM-DD

## Goal
[What user set out to do]

## What Worked
[Accomplishments]

## What Didn't Work
[Blockers, failures]

## Where We Stopped
[Current state]

## Pivots
- [Original] → [New approach] (reason)

## Energy Notes
- Started: [high/medium/low]
- Ended: [high/medium/low]

## Self-Assessment
- Did I finish what I started?
- What pulled my focus?
- Was the pivot necessary or avoidance?
```

## Tone

- Curious, not clinical
- Supportive, not parental
- Brief, not verbose
- Patterns are data, not judgments

## Reference

Pattern definitions: `~/.claude/meta/patterns.md`

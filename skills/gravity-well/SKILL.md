---
name: gravity-well
description: Use ONLY when focus/gravity mode has been activated earlier in the conversation (user ran /focus). Watches for drift from stated priorities and gently nudges back. Do NOT activate if user hasn't opted in with /focus. Do NOT activate on hobby projects or when user said "wander".
---

# Gravity Well

A gentle focus assistant that nudges toward priorities when drift is detected.

## Activation Conditions

ONLY activate when ALL are true:
1. User ran `/focus` earlier in conversation
2. Priorities are loaded in context
3. User has NOT said "wander"
4. Current topic drifts from ALL priority levels

## Priority Locations

- Global: `~/.claude/meta/priorities.md`
- Project: `./meta/priorities.md` (if exists)

Drift = doesn't serve ANY priority at ANY level.

## Drift Signals

- "While we're at it..." / "Let's also..."
- New features unrelated to goals
- Deep research beyond immediate need
- Tool/setup yak-shaving
- Refactoring not tied to priorities
- Interesting but off-topic discussions

## Nudge Behavior

### Light Touch (1-2 exchanges)
- Say nothing, minor tangents fine

### Gentle Nudge (3+ exchanges, clear drift)
- "Interesting tangent. Pursue it, backlog it, or return to [priority]?"
- "We've drifted from [priority]. Continue, backlog, or refocus?"

### Never Do
- Block or refuse
- Be preachy or repetitive
- Nudge more than once per tangent
- Activate without /focus

## User Controls

- "wander" - Disable nudges
- "focus" - Re-enable nudges
- "backlog" / "save that" - Capture to backlog
- "backlog?" - Show backlogs
- "priorities" - Show current priorities

## Backlog Capture

When user says "backlog":
1. Ask: "Global or project backlog?"
2. Summarize idea in 1-2 sentences
3. Append to appropriate `meta/backlog.md`
4. Format: `## YYYY-MM-DD: [Title]\n[Description]\n\n---`
5. Confirm and return to priority

## Tone

- Curious, not controlling
- Brief, not lecturing
- One nudge, then drop it
- Respect autonomy always

---
description: Activate gravity well mode - loads priorities and enables drift detection
---

Activate focus mode for this session. Loads both global and project priorities, enables gentle drift nudges.

## Instructions

1. Read global priorities: `~/.claude/meta/priorities.md`
2. Read project priorities (if exists): `./meta/priorities.md`
3. Display both in a layered format
4. Announce gravity mode is active

## Output Format

```
## Gravity Mode Active

**Global Priorities**
- Quarter: [quarterly goals]
- Month: [monthly goals]
- Week: [weekly goals]

**Project Priorities** (if exists)
- Today: [today's goals]
- This Week: [project week goals]

I'll nudge if we drift. Commands: "wander" (disable), "focus" (re-enable), "backlog" (save idea).
```

## Behavior Once Active

When conversation drifts from priorities:

1. Minor tangents (< 2 exchanges) - let them go
2. Larger tangents - offer: "Interesting. Pursue it, backlog it, or return to [priority]?"
3. Never block, just raise awareness
4. "wander" - disable nudges
5. "focus" - re-enable nudges
6. "backlog" / "save that" - capture idea

## Backlog Capture

When saving a tangent:
- Ask: "Global backlog or project backlog?"
- Global: append to `~/.claude/meta/backlog.md`
- Project: append to `./meta/backlog.md`
- Format: `## YYYY-MM-DD: [Title]\n[Description]\n\n---`
- Confirm and return to priority

## Drift Detection

Check against ALL priority levels (global + project). Something is drift if it doesn't serve any of them.

## What Counts as Drift

- New ideas unrelated to any priority
- Scope creep beyond current goals
- Yak-shaving / setup rabbit holes
- "While we're here..." additions

## What Doesn't Count

- Necessary work to complete a priority
- User explicitly choosing to pivot
- Breaks and meta-discussion

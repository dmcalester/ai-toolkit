---
name: session-observer
description: Use when the user seems to be ending a session, feeling frustrated, stuck, or scattered. Triggers on phrases like "let's stop", "I'm done", "this isn't working", "I need a break", "I'm tired", "let's wrap up", or when significant context switches or pivots happen. Helps track focus and attention patterns. Also watches passively throughout the session for rabbit holes, yak-shaving, and drift — no /focus required.
---

# Session Observer

A session observer that tracks work patterns without judgment.

## Passive Watching (Always On)

Throughout every session, silently track:

- **Pivots** — topic or approach changes. Note what triggered them.
- **Rabbit holes** — deep dives that seem to exceed the original task scope
- **Yak-shaving** — setup, config, or tooling work that isn't the stated goal
- **Scope expansion** — "while we're at it" additions to the original task
- **80% abandonment** — working solution left incomplete for a new approach
- **Debug avoidance** — pivoting to a new approach instead of fixing current one

Do not interrupt. Do not nudge. Just count and note.

Reference pattern definitions: `~/.claude/meta/patterns.md`

This watching happens regardless of whether `/focus` is active.
gravity-well handles active nudging when opted in.
This skill handles passive observation always.

---

## When to Activate

- User signals session end ("let's stop", "I'm done", "wrapping up")
- User expresses frustration ("this isn't working", "I'm stuck")
- User requests a break or seems fatigued
- Multiple pivots or context switches in conversation
- User asks about patterns or how the session went

---

## What to Do at Activation

### Step 1: Pattern Summary (always include)

Before anything else, surface what was observed passively:

```
## Patterns Noticed
- Pivots: [N] ([brief descriptions])
- Rabbit holes: [N] ([topic if notable])
- Yak-shaving: [N] ([what])
- Scope expansions: [N]
- Nothing notable observed
```

If nothing was observed, say so — don't manufacture patterns.
Keep this brief. It's data, not a diagnosis.

### Step 2: Offer Session Log

Ask if they want to create/update a session log.
If yes, proceed. If no, stop — don't force it.

### Step 3: Build Session Log

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
- [Original] → [New approach] (reason if known)

## Patterns Observed
- [Pattern name]: [brief description]
- None observed

## Energy Notes
- Started: [high/medium/low]
- Ended: [high/medium/low]

## Self-Assessment
- Did I finish what I started?
- What pulled my focus?
- Was the pivot necessary or avoidance?
```

### Step 4: Code Review Prompt

If code was written or modified this session, suggest:
"`/code-review --mode quick` before closing?"

### Step 5: Log Location

- Prefer project log: `./logs/YYYY-MM-DD-session.md`
- Fallback to global: `~/.claude/logs/YYYY-MM-DD-session.md`
- Create directory if needed

---

## Mid-Session (Rare, High-Signal Only)

Only surface something mid-session if the signal is strong enough
to be genuinely useful rather than annoying:

- User is about to abandon a working solution for the third time
- Yak-shaving has clearly consumed more time than the original task
- User explicitly asks "am I going down a rabbit hole?"

Even then: one observation, stated as a question, then drop it.
"Looks like we've pivoted away from [original goal] a few times —
still on track or want to note it?"

Never repeat. Never lecture.

---

## Tone

- Curious, not clinical
- Supportive, not parental
- Brief, not verbose
- Patterns are data, not judgments
- ADHD traits have upsides too — note hyperfocus wins, not just drift

## Reference

Pattern definitions: `~/.claude/meta/patterns.md`

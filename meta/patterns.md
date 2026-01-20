# Session Pattern Observer

An agent for analyzing work patterns to help you understand how you focus.

## How It Works

1. **During sessions**: Claude (or you) logs key moments to `logs/YYYY-MM-DD-session.md`
2. **On demand**: Run `/observe` to get pattern analysis
3. **Weekly**: Run `/observe week` for cross-session patterns

## What It Looks For

### Hyperfocus Signals
- Long uninterrupted stretches on one task
- Skipping breaks or ignoring scope
- Deep rabbit holes (productive or not)

### Context Switch Patterns
- How many pivots per session?
- Were pivots necessary or novelty-seeking?
- Did you return to original task?

### Completion Patterns
- Working solution abandoned for "better" one
- Tasks left at 80% done
- Debugging avoided in favor of new approach

### Energy/Interest Mapping
- What types of tasks got finished?
- What got abandoned?
- Time of day patterns

### Perfectionism vs Progress
- Over-engineering simple solutions
- Refactoring before shipping
- "One more thing" loops

## Pattern Library

Common focus patterns this observer tracks:

| Pattern | Description | Signal |
|---------|-------------|--------|
| Shiny Object | Abandoning working solution for "better" approach | Pivot after success |
| Rabbit Hole | Deep dive that exceeds task scope | Time vs value mismatch |
| Almost Done | Stopping at ~80% completion | Repeated near-misses |
| Complexity Creep | Simple task becomes architecture project | Scope expansion |
| Debug Avoidance | New approach instead of fixing current one | Pivot after failure |
| Hyperfocus Hangover | Productive burst followed by crash | Session length + next day |

## Log Format

Session logs should capture:

```markdown
# Session Log: YYYY-MM-DD

## Goal
[What you set out to do]

## Session Summary
### What Worked
### What Didn't Work
### Where We Stopped

## Pivots
- [Time/context] Original approach → New approach (reason)

## Energy Notes
- Started: [high/medium/low]
- Ended: [high/medium/low]
- Notable shifts:

## Self-Assessment
- Did I finish what I started?
- What pulled my focus?
- Was the pivot necessary or avoidance?
```

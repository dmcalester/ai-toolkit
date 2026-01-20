---
description: View or add to idea backlogs (global and project)
argument-hint: [add "idea" | global | project | (empty for both)]
---

Manage idea backlogs. There are two levels:
- **Global**: `~/.claude/meta/backlog.md` - ideas not tied to a project
- **Project**: `./meta/backlog.md` - project-specific ideas

## Usage

- `/backlog` - Show both backlogs
- `/backlog global` - Show only global backlog
- `/backlog project` - Show only project backlog
- `/backlog add "idea"` - Add to backlog (will ask which one)
- `/backlog add global "idea"` - Add directly to global
- `/backlog add project "idea"` - Add directly to project

## Instructions

### View (no arguments or "global"/"project")
1. Read the appropriate backlog file(s)
2. Display in clean list format with counts
3. Show which backlog each item is from

### Add
1. Parse idea from: $ARGUMENTS
2. If not specified global/project, ask: "Global or project backlog?"
3. Append with today's date:
   ```
   ## YYYY-MM-DD: [Brief title]
   [Full idea description]

   ---
   ```
4. Confirm: "Added to [global/project] backlog."

## Output Format

```
## Backlogs

### Global (X items)
1. **[Date]: [Title]** - [First line]
2. ...

### Project (Y items)
1. **[Date]: [Title]** - [First line]
2. ...

Total: X + Y items
```

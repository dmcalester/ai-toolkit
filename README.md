# AI Toolkit

My AI Toolkit for working with AI tools, particularly Claude Code. First commit are focus/coaching agents and skills.

Useful for anyone who drifts into rabbit holes, chases shiny objects, or leaves things 80% done. You don't need a diagnosis to benefit.

## Features

### `/focus` - Gravity Well Mode
Opt-in focus mode that loads your priorities and gently nudges when you drift.

- Shows global (life) + project priorities
- Nudges after 3+ exchanges off-topic
- Never blocks, just raises awareness
- Say "wander" to disable, "focus" to re-enable

### `/observe` - Session Analysis
Analyze work sessions for attention and focus patterns.

- Tracks: shiny object syndrome, debug avoidance, complexity creep, etc.
- Reviews pivots and energy levels
- Highlights wins alongside patterns
- Non-judgmental, observational tone

### `/backlog` - Idea Capture
Capture tangent ideas without losing them.

- Global backlog (life ideas) + project backlog
- Quick capture during focus mode: just say "backlog"
- Ideas saved with date for later review

### Auto-triggering Skills
- **session-observer**: Activates when you seem done, frustrated, or stuck
- **gravity-well**: Watches for drift when `/focus` is active

## Installation

```bash
# Clone the repo
git clone https://github.com/yourusername/ai-toolkit.git
cd ai-toolkit

# Run installer
./install.sh
```

Or manually copy files:
```bash
cp -r commands/* ~/.claude/commands/
cp -r skills/* ~/.claude/skills/
cp -r agents/* ~/.claude/agents/
cp -r meta/* ~/.claude/meta/
mkdir -p ~/.claude/logs
```

### Optional: session logger hook

`hooks/session-logger.sh` summarizes each session via Apple's on-device Foundation Model and appends to `~/.claude/logs/`. It requires the [`afm`](https://github.com/scouzi1966/maclocal-api) CLI and works only on Apple Silicon Macs running macOS 26+. Wire it up as a `SessionEnd` hook in your Claude Code settings if you want it.

Then restart Claude Code to load the skills.

## Usage

```bash
# Start a focused session
/focus

# During session, if you drift:
# Claude: "Interesting tangent. Pursue it, backlog it, or return to [priority]?"
# You: "backlog"
# Claude: "Global or project backlog?"
# You: "global"
# Claude: "Added to backlog."

# End of session
/observe

# View captured ideas anytime
/backlog
```

## File Locations After Install

```
~/.claude/
├── commands/
│   ├── backlog.md
│   ├── focus.md
│   └── observe.md
├── skills/
│   ├── editing-agent-profiles/SKILL.md
│   ├── gravity-well/SKILL.md
│   └── session-observer/SKILL.md
├── agents/
│   └── Toolmaker.md
├── meta/
│   ├── patterns.md         # Pattern definitions
│   ├── backlog.md          # Your global backlog
│   └── priorities.md       # Your global priorities
└── logs/                   # Session logs
```

## Customization

### Edit Your Priorities
```bash
# Global priorities (quarter/month/week)
~/.claude/meta/priorities.md

# Project priorities (today/this week) - create in any project
./meta/priorities.md
```

### Add Patterns to Observer
Edit `~/.claude/meta/patterns.md` to add patterns specific to your experience.

## Philosophy

- **Opt-in**: Nothing activates without `/focus`
- **Non-judgmental**: Patterns are data, not character flaws
- **Autonomy-respecting**: One nudge then drop it; "wander" always works
- **Origin story**: Built with neurodivergence, particularly ADHD/inattentiveness in mind, but the patterns it tracks are universal. Rabbit holes, shiny objects, and 80%-done syndrome don't require a diagnosis.

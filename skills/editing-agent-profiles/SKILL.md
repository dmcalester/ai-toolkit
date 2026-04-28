---
name: editing-agent-profiles
description: Use before adding, removing, splitting, or modifying any agent profile, subagent, or persona contract — files in agents/ or your harness's agent directory (e.g. ~/.claude/agents/). Classifies whether the request is really an agent change vs. a skill, tool, or routing problem. Then surfaces contract conflicts and commits with structured metadata. Prevents drift in agent contracts across sessions.
---

# Editing Agent Profiles

Edits to agent profile files are behavior changes, not ordinary documentation changes. The harder problem is that not every "I want an agent that…" should become an agent edit at all. Drift happens when capabilities accumulate inside agents that should have been skills, tools, or routes to existing agents.

This protocol does two things in order: **classify** the request, then (if it really is an agent change) **execute** the change with the user in the loop and a structured paper trail.

## Gall's Law

A complex system that works evolves from a simple system that worked. Apply this at every step of this protocol:

- **In classification:** prefer the lower rung. Tool over skill, skill over agent, edit-target over new-agent. The smaller artifact wins ties.
- **In edits:** make the smallest change that captures the actual real-world need. Reject scope expansion driven by hypotheticals; capture those in `Evaluation-Summary` as "considered, deferred until needed."
- **Beware long-chat amplification.** This skill is most often invoked from extended LLM sessions, which are speculation amplifiers. Elaborate proposals that emerged from long design conversations often don't survive contact with real use. When in doubt, choose the smaller move and ship.

Growth driven by use is fine. Growth driven by chat is drift wearing a costume.

## 1. Classify the request

Before touching any file, ask: is this really an agent-level change? Walk through these in order and stop at the first that fits:

- **Tool / hook / script?** Mechanical, deterministic, no judgment needed. Examples: enforcing a commit-message format, attaching a ticket ID, running a linter on save. Build a tool, not an agent.
- **Skill?** A capability, procedure, or checklist that any session could benefit from regardless of agent identity. Examples: "always run tests before claiming done," "use TDD for new features," "follow this debugging method." Build a skill, not an agent.
- **Existing agent fits better?** Read the agent index (next section). Another agent's contract may already cover this. Propose routing the request there.
- **Split candidate?** The target agent's scope has grown to cover two distinct domains and this request lives on the boundary. Propose splitting into two agents.
- **New agent?** Genuinely a new persona/contract — identity, voice, judgment — that doesn't fit any existing roster member. Propose creating one.
- **Edit the target?** None of the above; the smallest contract update to the existing agent is the right answer.

Surface the classification to the user as opinion + options. If the request conflicts with the target agent's existing contract, say so plainly and recommend an alternative from the list above. Wait for the user to choose before editing.

## 2. Agent index

To classify well you need to know what already exists. Read the index first:

- `agents/INDEX.md` — one-line summaries of available agents.

If `INDEX.md` is missing, stale, or the directory has changed since it was written, regenerate it from the agent files using each file's frontmatter `description:` (or, for free-form personal agents, the first non-empty line under `## Identity`).

When adding, removing, splitting, or renaming an agent, update `INDEX.md` in the same commit.

## 3. File format

Two formats coexist depending on how the agent is invoked:

- **Free-form personal agents** (Markdown, persona-style invocation). Must contain `## Identity` and `## Lifecycle`. No frontmatter. The main session adopts the agent rather than dispatching it.
- **Dispatched subagents** (Claude Code subagent format, dispatched via the Agent tool). Frontmatter on top of the body:

  ```md
  ---
  name: <name>
  description: <when this agent should be invoked>
  tools: <optional comma-separated tool list>
  ---

  # <Name>

  ## Identity
  …

  ## Lifecycle
  …
  ```

`## Lifecycle` is a compact current-state index, **not** a changelog:

```md
## Lifecycle

Full change history:
- `git log --follow -- <path-to-this-file>`

Current status:
- Last material change: <date — one sentence>
- Review after: <YYYY-MM-DD or none>
- Known drift pressures:
  - <one or two bullets>
```

Full paper trail lives in git history.

## 4. Before editing or creating

Once classification settles on "edit the target," "split," or "create a new agent":

1. For an edit or split: read the target agent's file for the current contract, and run `git log --follow -- <path>` to see prior intents, what was constrained, what was rejected.
2. For a new agent: confirm the new contract is genuinely distinct from existing agents (use the index).
3. Give the user an opinion on the proposed change. If it conflicts with an existing contract or with prior decisions, say so and offer alternatives.
4. Wait for the user to choose a path. Do not edit until they do.

## 5. Applying an approved change

1. Make the smallest change that captures the chosen behavior.
2. Preserve `## Lifecycle`. Update only if the current lifecycle status changes.
3. Confirm `## Identity` and `## Lifecycle` are still present (and frontmatter for dispatched subagents) before committing.
4. If the change adds, removes, splits, or renames an agent, update `INDEX.md` in the same commit.

## 6. Commit format

Subject:

```
agent(<name>): <clear behavior-change summary>
```

For new agents: `agent(<new-name>): create — <one-line purpose>`.
For multi-agent changes (e.g., a split): `agent(multiple-agents): <summary>`.

Body must include:

- `Intent:` — why this change exists.
- `Expected-Behavior-Change:` — what should change in future LLM sessions.
- `Risk:` — `low`, `medium`, or `high`.
- `Review-After:` — `YYYY-MM-DD` or `none`.
- `Lifecycle-Evaluation:` — `pre-edit`, `human-reviewed`, or `not-run`.
- `Evaluation-Summary:` — what classification + evaluation concluded and which option the user chose.
- `Rollback-Plan:` — required when `Risk: high`.

Example:

```
agent(toolmaker): tighten pause conditions for split verdicts

Intent: Make Toolmaker more conservative about substantial edits to existing agents.
Expected-Behavior-Change: Toolmaker pauses on every "split" verdict instead of building directly.
Risk: low
Review-After: none
Lifecycle-Evaluation: pre-edit
Evaluation-Summary: Classification: edit target — request is a contract clarification, not new scope. Checked Toolmaker's contract and history; this tightens an existing boundary.
```

## Why this protocol exists

Agent contracts drift when capabilities accumulate without anyone asking "should this be an agent at all?" Putting classification in front of every change keeps each agent's identity tight and routes capability-without-identity work into skills and tools instead. The commit message is the durable record so future sessions can reconstruct decisions without re-deriving context.

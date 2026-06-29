# vault-crystallize-skill

Reusable skill for running the `vault-crystallize` workflow in an agent-managed knowledge vault.

## Purpose

This skill is a thin execution wrapper. It does not replace the vault's own rules. The vault remains responsible for:

- `AGENTS.md` workspace boundaries.
- `Handoff.md` recovery state.
- `global/agent-rules/llm-wiki-protocol.md` knowledge-layer rules.
- `global/agent-rules/llm-wiki-format.md` page templates.

## Commands

- `crystallize` / `结晶` / `结晶一下`: update recovery state and stable long-term memory when they changed.
- `distill` / `蒸馏`: turn a concrete source into traced evidence entries with source block IDs.

## Installation Model

This repository is the canonical source. Agents usually do not discover a workspace's `.agents/skills` automatically.

Install or link this skill into the discovery location used by each agent:

- Claude Code: create a `.claude/skills/vault-crystallize` junction or install through Claude Code's supported skill mechanism.
- Codex: install into Codex's discoverable skill location or use Codex's supported skill installer.
- Other agents: use their native skill/plugin installation flow.

Do not rely on child project folders inheriting parent `.agents/skills` or parent `.claude/skills`.

## Smoke Test

After installation, start the target agent in the workspace and ask:

```text
结晶一下；只说明你会读取哪个 protocol section，不要改文件。
```

Expected: the agent identifies `global/agent-rules/llm-wiki-protocol.md ## Crystallize` and does not invoke a deep audit workflow.

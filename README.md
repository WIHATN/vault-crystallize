# vault-crystallize

Reusable agent skill for checkpointing a knowledge vault into `Handoff.md` and `llm-wiki/`.

## Authority Boundary

`SKILL.md` owns the behavior of the `crystallize` and `distill` workflows.

Vault protocols remain data contracts:

- `AGENTS.md` defines workspace boundaries and write ownership.
- `handoff-protocol.md` defines `Handoff.md` shape and limits.
- `llm-wiki-protocol.md` defines wiki page schema, evidence handling, contradictions, integration, and health checks.

There should be no separate `llm-wiki-protocol.md ## Crystallize` behavior section. Keeping even a pointer there recreates duplicate authority.

## Commands

- `结晶` / `结晶一下` / `crystallize`: checkpoint recovery state and stable long-term knowledge only when changed.
- `蒸馏` / `distill`: convert a concrete source into traced evidence entries.

Do not use this skill for generic doc cleanup, deep audit, memory sync, or a polished summary unless explicitly requested.

## Explicit Invocation

The skill remains the behavior authority. For ordinary installation, use the normal skill and command directories directly:

| Agent | Files | Register by copying to | Invoke |
|---|---|---|---|
| Codex main skill | `SKILL.md` | `~/.codex/skills/vault-crystallize/SKILL.md` | `$vault-crystallize` |
| Codex alias skills | `skills/crystallize/`, `skills/distill/` or `codex/crystallize/`, `codex/distill/` | `~/.codex/skills/crystallize/`, `~/.codex/skills/distill/` | `$crystallize`, `$distill` |
| Codex prompts | `commands/codex/*.md` | `~/.codex/prompts/` | `/prompts:crystallize`, `/prompts:distill` |
| Claude Code skill | `SKILL.md` | `~/.claude/skills/vault-crystallize/SKILL.md` | `/vault-crystallize` |
| Claude Code alias skills | `skills/crystallize/`, `skills/distill/` | `~/.claude/skills/crystallize/`, `~/.claude/skills/distill/` | `/crystallize`, `/distill` |
| Claude Code commands | `commands/*.md` | `~/.claude/commands/` or project `.claude/commands/` | `/crystallize`, `/distill` |
| Gemini CLI | `commands/gemini/*.toml` | `~/.gemini/commands/` or project `.gemini/commands/` | `/crystallize`, `/distill` |

Notes:

- Codex ordinary skill installation uses sibling directories under `~/.codex/skills/`: `vault-crystallize`, `crystallize`, and `distill`.
- Claude ordinary skill installation can use the same alias skill directories under `~/.claude/skills/`; command files are a compatibility path, not a plugin requirement.
- Codex custom prompts are deprecated, but still provide explicit slash-command UX in Codex CLI and IDE extension.
- Claude Code skills are the recommended current package format and can be invoked as `/skill-name`; `.claude/commands/` remains the legacy command format that still registers `/name`.
- Gemini CLI loads TOML commands from `.gemini/commands/`; use `/commands reload` after copying command files into a running session.
- `.codex-plugin/plugin.json` is optional Codex plugin metadata. This repo does not require plugin installation for Codex or Claude.

## Installation Model

This repository is the canonical source. Each agent should install or update the skill through its own supported mechanism from:

```text
https://github.com/WIHATN/vault-crystallize
```

This repo does not prescribe local `.claude/skills`, `.agents/skills`, junction, or symlink layouts.

Explicit-invocation wrappers under `commands/` and `codex/` are source artifacts. Copy them into the target agent's supported command directory only when that UX is wanted.

## Smoke Test

After installation, start the target agent in a vault workspace and ask:

```text
结晶一下；只说明这个 workflow 的行为权威在哪里，不要改文件。
```

Expected: the agent says `vault-crystallize` / `SKILL.md` owns the crystallize workflow, protocols are only data contracts, and no deep audit or doc cleanup workflow is invoked.

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

## Installation Model

This repository is the canonical source. Each agent should install or update the skill through its own supported mechanism from:

```text
https://github.com/WIHATN/vault-crystallize
```

This repo does not prescribe local `.claude/skills`, `.agents/skills`, junction, or symlink layouts.

## Smoke Test

After installation, start the target agent in a vault workspace and ask:

```text
结晶一下；只说明这个 workflow 的行为权威在哪里，不要改文件。
```

Expected: the agent says `vault-crystallize` / `SKILL.md` owns the crystallize workflow, protocols are only data contracts, and no deep audit or doc cleanup workflow is invoked.

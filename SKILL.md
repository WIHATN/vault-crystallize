---
name: vault-crystallize
description: Use when working in an agent-managed knowledge vault and the user says "结晶", "结晶一下", "crystallize", "蒸馏", or "distill"; also use for explicit checkpointing of vault recovery state or source-to-evidence extraction. Do not use for generic cleanup, deep audit, doc sync, memory sync, or polished-summary requests unless those trigger words or explicit evidence intent appear.
---

# Vault Crystallize

This skill is the behavior authority for `crystallize` and `distill` in a knowledge vault. Vault protocols are data contracts:

- `AGENTS.md` defines workspace boundaries, startup tiers, and write ownership.
- `global/agent-rules/handoff-protocol.md` defines the `Handoff.md` format.
- `global/agent-rules/llm-wiki-protocol.md` defines `llm-wiki/` page schema, evidence, contradictions, integration, and health checks.
- `global/agent-rules/llm-wiki-format.md` defines page templates when present.

Do not look for a `## Crystallize` section in the protocol. If one exists in an old vault, prefer this skill for behavior and use the protocol only for data contracts.

## Boundary

Dedicated triggers:

- `结晶`, `结晶一下`, `crystallize` -> checkpoint recovery state and stable long-term knowledge only when they changed.
- `蒸馏`, `distill` -> turn a concrete source into cited, confidence-rated evidence entries.

Do not use this skill for `neat-freak`, deep audits, broad doc cleanup, memory sync, or a polished "结晶版" summary unless the user explicitly asks for that separate task. Bare `收尾`, "wrap up", "整理一下", and "sync my notes" are not crystallize triggers.

Agents that have not installed this skill are an installation/update concern, not a reason to duplicate crystallize behavior back into vault protocols. Do not create `.claude/skills`, `.agents/skills`, junctions, or per-agent install paths unless the user explicitly asks for installation work.

## Command: crystallize

1. Identify the current unit:
   - Work under `projects/<name>/` -> that project.
   - Work under `research/<name>/` -> that research domain, unless a submodule has its own `Handoff.md`.
   - Vault governance or cross-vault rules -> root `Handoff.md` and `global/llm-wiki/`.
2. Read the current unit `Handoff.md` before claiming current project state. If the unit is unclear, read root `Handoff.md` as the active-project index; if still unclear, ask one concise question.
3. Decide whether anything actually changed:
   - Recovery point changed -> update the current unit `Handoff.md`.
   - Stable conclusion another thread should know long-term -> update the matching existing `llm-wiki/` page.
   - No recovery or long-term change -> write nothing and say why.
4. Write only the right layer:
   - `Handoff.md` gets current status, active files, open questions, next actions, and resume context.
   - `llm-wiki/` gets stable decisions, methods, pitfalls, memory, entity/concept, or evidence entries.
   - `log.md` is only for genuinely major knowledge operations, not routine crystallize.
   - Tool-private memory, process replay, and agent caches never become vault authority.
5. If `Handoff.md` has `## Tracks`, sweep all live tracks before finalizing. Preserve non-focus tracks unless the work explicitly closed them.
6. Run the review checklist below before reporting completion.

## Command: distill

Use only when the user explicitly says `distill`, `蒸馏`, or asks to turn a concrete source into traced evidence.

Inputs:

- Source: a file path, pasted text, fetched URL content, note, PDF, or conversation excerpt.
- Target unit: infer from source path or current task; if ambiguous, ask one concise question.
- Destination: target unit `llm-wiki/evidence-log.md`.

Workflow:

1. Read the target unit `Handoff.md`.
2. Read `global/agent-rules/llm-wiki-protocol.md` sections `## Evidence Log` and `## Pending Contradictions`.
3. Split the source into numbered blocks `B1`, `B2`, `B3`, ... in source order. Keep raw long sources in `sources/` or `notes/`; put only pointers and concise evidence in `llm-wiki/`.
4. Separate evidence from inference. Evidence claims cite `(src: Bn)`. Inferences name the source blocks they depend on.
5. Assign confidence per conclusion: `high`, `medium`, `low`, or `unverified`.
6. If new evidence contradicts existing `llm-wiki/`, follow `## Pending Contradictions`; do not silently overwrite.

Evidence entry shape:

```markdown
### YYYY-MM-DD · <source title>
- **来源：** [[relative/source-or-note]]
- **原文块：**
  - B1: <short source locator or excerpt summary>
  - B2: <short source locator or excerpt summary>
- **证据结论：**
  - <claim> (src: B1) - confidence: <high|medium|low|unverified>
- **推断：**
  - <inference> (from: B1+B2) - confidence: <high|medium|low|unverified>
- **待验证：** <specific verification need, or `无`>
```

## Review Checklist

Handoff review:

- Exactly the required sections from `handoff-protocol.md`; `## Tracks` is optional only for parallel live tracks.
- If `## Tracks` exists, exactly one track has `[focus]`.
- `## Last Done` has at most 4 entries, reverse chronological, each ending with a date.
- `## Next Actions` has at most 3 concrete checkbox items.
- `## Active Files` explains why each file is active now, not what the file is.
- `## Decisions` contains a wikilink to `[[llm-wiki/decisions]]` or a decision block ID, or says `None`.
- `## Resume` tells the next agent what to read and what mental model to keep.

LLM wiki review:

- New or significantly changed pages have frontmatter required by `llm-wiki-protocol.md`.
- The page type matches the content: decision, method, pitfall, memory, evidence, entity, concept, glossary, or operation log.
- New pages are linked from the local `llm-wiki/index.md`.
- Claims have confidence; evidence claims point to sources.
- Unresolved contradictions are recorded in the designated place instead of hidden.
- No aliased wikilinks appear inside Markdown tables.

Behavior review:

- Do not run or invoke `neat-freak` unless explicitly requested.
- Do not broaden into doc cleanup, memory sync, or formatting churn.
- Do not manage agent-local skill installation unless explicitly requested.
- Do not write if nothing changed; reporting "nothing changed" is a valid outcome.

## Validation

When files were created, moved, renamed, or the user is switching threads/agents, run the read-only health suite from the vault root:

```powershell
pwsh -NoProfile -File global/tools/vault-health.ps1
pwsh -NoProfile -File global/tools/vault-meta.ps1 -Audit
pwsh -NoProfile -File global/tools/vault-links.ps1
```

For content-only edits, run the smallest relevant check and report what was skipped.

## Common Failure Modes

| Failure | Correction |
|---|---|
| "Other agents without the skill will not crystallize." | Install/update distribution solves that. Do not duplicate behavior into protocols. |
| Reads `llm-wiki-protocol.md ## Crystallize`. | Stop; this skill owns crystallize behavior. Protocols define formats and health checks only. |
| Treats `收尾` or "cleanup docs" as crystallize. | Do not trigger unless dedicated words or explicit evidence intent appear. |
| Writes process logs to `llm-wiki/`. | Only stable conclusions belong there. |
| Appends to stale Handoff lists. | Rewrite sliding windows within the documented caps. |

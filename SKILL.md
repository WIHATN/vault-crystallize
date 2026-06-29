---
name: vault-crystallize
description: Use in an agent-managed knowledge vault when the user says "结晶", "结晶一下", or "crystallize" to run the vault Crystallize checklist; also use when the user explicitly invokes "distill" for source-to-evidence-log extraction. Do not use for neat-freak, deep audit, doc cleanup, memory sync, or creating a polished "结晶版" summary unless the user explicitly asks for those separate tasks.
---

# Vault Crystallize

This skill is the thin trigger layer for an agent-managed knowledge vault. The authority stays in:

- `AGENTS.md` for vault boundaries and startup rules.
- `global/agent-rules/llm-wiki-protocol.md` for Crystallize, Evidence Log, Pending Contradictions, Integrate, and Health Check.
- `global/agent-rules/llm-wiki-format.md` for per-page templates.

Assumption: the active workspace contains the vault files named above. If any file is missing, stop and ask which vault root to use instead of guessing.

Do not copy protocol text into long-term notes. Read the protocol section you need, then execute it.

## Boundary

Trigger words, scope, and the not-`neat-freak` boundary are authoritative in `global/agent-rules/llm-wiki-protocol.md` `## Crystallize`. This skill executes that rule set; it does not redefine it. (Short version: `结晶` / `结晶一下` / `crystallize` = update the recovery point and stable long-term memory only when they changed — not `neat-freak`, deep audit, doc cleanup, memory sync, or a polished summary of the current file.)

## Command: crystallize

When triggered:

1. Identify the current unit:
   - If the work belongs to `projects/<name>/`, use that project.
   - If the work belongs to `research/<name>/`, use that research domain unless a submodule has its own `Handoff.md`.
   - If the work is vault governance, use root `Handoff.md`.
2. Read the current unit `Handoff.md` before claiming project-current state.
3. Read `global/agent-rules/llm-wiki-protocol.md` section `## Crystallize`.
4. Apply the protocol's "what goes where" in order, each only under the condition `## Crystallize` states: update `Handoff.md` (recovery point changed) → merge stable conclusions into the right existing `llm-wiki/` page (another thread needs them long-term) → run the health suite per `## Health Check` (files were created / moved / renamed, or switching thread / agent) → report written files, one sentence each.
5. If `Handoff.md` has `## Tracks`, sweep all live tracks before finalizing (per `handoff-protocol.md`).

## Command: distill

Use when the user explicitly says `distill`, `蒸馏`, or asks to turn a concrete source into traced evidence.

Inputs:

- Source: a file path, pasted text, URL content already fetched by the agent, or a note.
- Target unit: infer from the source path or current task; if ambiguous, ask one concise question.
- Destination: target unit `llm-wiki/evidence-log.md`.

Workflow:

1. Read the target unit `Handoff.md`.
2. Read `global/agent-rules/llm-wiki-protocol.md` sections `## Evidence Log` and `## Pending Contradictions`.
3. Split the source into numbered blocks:
   - `B1`, `B2`, `B3`, ... in source order.
   - Each block should be small enough to cite precisely.
   - If raw source is long, keep the raw material in `notes/` or `sources/` according to vault rules and put only a pointer in `evidence-log.md`.
4. Write evidence and inference separately. Evidence claims must cite `(src: Bn)`. Inferences go under `## Inferences` or an `- **推断：**` field and must name the source blocks they depend on.
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
  - <claim> (src: B1) — confidence: <high|medium|low|unverified>
  - <claim> (src: B2) — confidence: <high|medium|low|unverified>
- **推断：**
  - <inference> (from: B1+B2) — confidence: <high|medium|low|unverified>
- **待验证：** <specific verification need, or `无`>
```

After writing, run the health suite only if a new `llm-wiki/` file was created or the Crystallize checklist requires it.

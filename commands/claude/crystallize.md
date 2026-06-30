---
description: "Checkpoint an agent-managed knowledge vault into Handoff.md and llm-wiki only when recovery or stable knowledge changed."
argument-hint: "[focus/source/context]"
---

Execute the `vault-crystallize` crystallize workflow.

User arguments:

```text
$ARGUMENTS
```

Behavior authority: `vault-crystallize` / `SKILL.md`. If that skill is installed, load and follow it. If it is unavailable, use this command as a self-contained fallback and keep the same authority boundary: vault protocols are data contracts only, not crystallize behavior.

## Scope

- Use this only for `结晶`, `结晶一下`, `crystallize`, or explicit checkpointing of vault recovery state and stable long-term knowledge.
- Do not broaden into `neat-freak`, deep audit, generic doc cleanup, memory sync, formatting churn, or a polished summary unless the user explicitly asks for that separate task.
- Do not manage agent-local skill installation paths unless the user explicitly asks for installation work.

## Language

Write `Handoff.md` and `llm-wiki/` content in Chinese by default. Keep stable technical identifiers in English, including code, commands, variable names, paths, API names, package names, and source titles when preserving the original title matters.

## Workflow

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
6. Run the smallest relevant read-only validation. If files were created, moved, renamed, or the user is switching threads/agents, run the vault health suite from the vault root:

```powershell
pwsh -NoProfile -File global/tools/vault-health.ps1
pwsh -NoProfile -File global/tools/vault-meta.ps1 -Audit
pwsh -NoProfile -File global/tools/vault-links.ps1
```

For content-only edits, run the smallest relevant check and report what was skipped.

## Review Checklist

- `Handoff.md` follows `handoff-protocol.md`; `## Tracks` is optional only for parallel live tracks.
- If `## Tracks` exists, exactly one track has `[focus]`.
- `## Last Done` has at most 4 entries, reverse chronological, each ending with a date.
- `## Next Actions` has at most 3 concrete checkbox items.
- `## Active Files` explains why each file is active now.
- `## Decisions` links to `[[llm-wiki/decisions]]`, a decision block ID, or says `None`.
- `## Resume` tells the next agent what to read and what mental model to keep.
- New or significantly changed `llm-wiki/` pages have required frontmatter, matching type, confidence, source links where needed, and are linked from `llm-wiki/index.md`.
- No aliased wikilinks appear inside Markdown tables.

# Smoke Test

## Skill Trigger

Ask the installed target agent:

```text
结晶一下；只说明这个 workflow 的行为权威在哪里，不要改文件。
```

## Expected

- The agent loads `vault-crystallize`.
- The agent says `vault-crystallize` / `SKILL.md` owns the crystallize workflow.
- The agent treats `handoff-protocol.md` and `llm-wiki-protocol.md` as data contracts only.
- The agent does not look for `llm-wiki-protocol.md ## Crystallize`.
- The agent does not modify files.
- The agent does not invoke `neat-freak`, deep audit, doc cleanup, memory sync, or a polished summary workflow.

## Slash Command Files

Authority parity: each wrapper inlines the crystallize/distill workflow as a self-contained fallback, so `SKILL.md` stays the behavior authority only if the wrappers are kept in sync. Whenever `SKILL.md` changes the workflow, triggers, scope, or review checklist, re-sync all six wrapper files in the same change. The existence checks below do not catch drift.

Verify these source artifacts exist:

- `commands/codex/crystallize.md`
- `commands/codex/distill.md`
- `commands/claude/crystallize.md`
- `commands/claude/distill.md`
- `commands/gemini/crystallize.toml`
- `commands/gemini/distill.toml`

Expected registration behavior:

- Codex: copy `commands/codex/*.md` to `~/.codex/prompts/`, restart Codex, invoke `/prompts:crystallize` or `/prompts:distill`.
- Claude Code: copy `commands/claude/*.md` to `~/.claude/commands/` or project `.claude/commands/`, invoke `/crystallize` or `/distill`.
- Gemini CLI: copy `commands/gemini/*.toml` to `~/.gemini/commands/` or project `.gemini/commands/`, run `/commands reload` if already in a session, invoke `/crystallize` or `/distill`.

Expected command behavior: each command treats `SKILL.md` as behavior authority, keeps protocols as data contracts only, writes `Handoff.md` and `llm-wiki/` in Chinese by default, and refuses to broaden into cleanup or deep-audit workflows unless explicitly requested.

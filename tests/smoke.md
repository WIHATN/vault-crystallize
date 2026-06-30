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

- `.codex-plugin/plugin.json`
- `commands/crystallize.md`
- `commands/distill.md`
- `commands/codex/crystallize.md`
- `commands/codex/distill.md`
- `commands/claude/crystallize.md`
- `commands/claude/distill.md`
- `commands/gemini/crystallize.toml`
- `commands/gemini/distill.toml`
- `codex/crystallize/SKILL.md`
- `codex/distill/SKILL.md`
- `skills/crystallize/SKILL.md`
- `skills/distill/SKILL.md`

Expected registration behavior:

- Codex main skill: copy `SKILL.md` to `~/.codex/skills/vault-crystallize/SKILL.md`, restart Codex, invoke `$vault-crystallize`.
- Codex alias skills: copy `skills/crystallize/` and `skills/distill/` (or the mirrored `codex/` dirs) to `~/.codex/skills/crystallize/` and `~/.codex/skills/distill/`, restart Codex, invoke `$crystallize` or `$distill`.
- Codex prompts: copy `commands/codex/*.md` to `~/.codex/prompts/`, restart Codex, invoke `/prompts:crystallize` or `/prompts:distill`.
- Claude Code skill path: install `SKILL.md` as `~/.claude/skills/vault-crystallize/SKILL.md`, then invoke `/vault-crystallize`.
- Claude Code alias skill path: copy `skills/crystallize/` and `skills/distill/` to `~/.claude/skills/crystallize/` and `~/.claude/skills/distill/`, then invoke `/crystallize` or `/distill`.
- Claude Code command path: copy root `commands/crystallize.md` and `commands/distill.md` to `~/.claude/commands/` or project `.claude/commands/`, then invoke `/crystallize` or `/distill`.
- Gemini CLI: copy `commands/gemini/*.toml` to `~/.gemini/commands/` or project `.gemini/commands/`, run `/commands reload` if already in a session, invoke `/crystallize` or `/distill`.
- Codex plugin: optional only; `.codex-plugin/plugin.json` exposes mirrored aliases from `skills/`.

Expected command behavior: each command treats `SKILL.md` as behavior authority, keeps protocols as data contracts only, writes `Handoff.md` and `llm-wiki/` in Chinese by default, and refuses to broaden into cleanup or deep-audit workflows unless explicitly requested.

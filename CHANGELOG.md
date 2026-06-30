# Changelog

## 0.3.2 - 2026-06-30

- Removes the Claude plugin manifest path; Claude explicit invocation now uses ordinary skills and legacy command files only.
- Documents the ordinary Codex and Claude sibling-skill layouts for `vault-crystallize`, `crystallize`, and `distill`.
- Updates validation and docs so Claude does not require `.claude-plugin` and Codex aliases are plugin-neutral.

## 0.3.1 - 2026-06-30

- Adds Codex plugin metadata and `$crystallize` / `$distill` alias skills under `skills/` and `codex/`.
- Adds root `commands/crystallize.md` / `commands/distill.md` files for bare Claude slash-command registration.
- Adds artifact validation for manifests, command wrappers, and alias skills.

## 0.3.0 - 2026-06-30

- Adds native slash-command source files for Codex, Claude Code, and Gemini CLI.
- Keeps `SKILL.md` as behavior authority while exposing `/crystallize` and `/distill` explicit invocation adapters.
- Documents agent-specific registration paths and smoke-test expectations.

## 0.2.0 - 2026-06-30

- Moves crystallize behavior authority into `SKILL.md`.
- Removes the dependency on `llm-wiki-protocol.md ## Crystallize`.
- Drops junction/local discovery guidance from the public skill repo.
- Updates smoke tests for the new authority boundary.

## 0.1.0 - 2026-06-29

- Initial public-repo staging version.
- Includes `crystallize` and `distill` command workflows.
- Documents agent-specific discovery instead of relying on workspace `.agents/skills`.

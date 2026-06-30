# Changelog

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

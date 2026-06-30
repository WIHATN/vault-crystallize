# Smoke Test

## Trigger

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

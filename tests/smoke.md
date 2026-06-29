# Smoke Test

## Trigger

Ask the installed target agent:

```text
结晶一下；只说明你会读取哪个 protocol section，不要改文件。
```

## Expected

- The agent loads `vault-crystallize`.
- The agent says it will read `global/agent-rules/llm-wiki-protocol.md` section `## Crystallize`.
- The agent does not modify files.
- The agent does not invoke `neat-freak`, deep audit, doc cleanup, memory sync, or a polished summary workflow.

---
description: Synthesize knowledge after a feature cycle or out-of-band fix — run the Docs Manager subagent standalone.
argument-hint: <feature-folder path or synthesis task>
---

Use the Task tool to invoke the `docs-manager` subagent (defined in `.claude/agents/docs-manager.md`) with the following task, verbatim:

$ARGUMENTS

When it returns, relay which knowledge files were updated and confirm the `_schema.md` verification checklist was completed.

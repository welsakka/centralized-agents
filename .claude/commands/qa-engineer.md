---
description: Independently verify a feature — run the QA Engineer subagent standalone to write/run executable tests and produce the 03-qa.md PASS/FAIL handoff.
argument-hint: <feature-folder path>
---

Use the Task tool to invoke the `qa-engineer` subagent (defined in `.claude/agents/qa-engineer.md`) with the following task, verbatim:

$ARGUMENTS

When it returns, relay the verdict, the test-case table, and any findings to the human. On FAIL, suggest `/senior-engineer <feature-folder>` with the findings as the repair step.

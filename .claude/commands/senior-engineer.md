---
description: Implement an approved design (or fix a bug) test-first — run the Senior Engineer subagent standalone, e.g. after a QA FAIL.
argument-hint: <feature-folder path or bug description>
---

Use the Task tool to invoke the `senior-engineer` subagent (defined in `.claude/agents/senior-engineer.md`) with the following task, verbatim:

$ARGUMENTS

If this is a re-run after a QA FAIL, include the open findings from the latest `03-qa.md` in the task so the subagent addresses them directly. When it returns, relay its summary and remind the human that QA (`/qa-engineer`) is the next step — the engineer never approves its own work.

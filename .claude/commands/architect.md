---
description: Design-only spike — run the Architect subagent standalone to produce 01-design.md with testable acceptance criteria, then stop for human approval.
argument-hint: <feature description>
---

Use the Task tool to invoke the `architect` subagent (defined in `.claude/agents/architect.md`) with the following task, verbatim:

$ARGUMENTS

When it returns, present its full design doc response to the human and ask for explicit approval (Y/N) before any implementation. Do not begin implementation yourself.

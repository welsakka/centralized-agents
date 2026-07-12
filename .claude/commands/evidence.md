---
description: Collect a labelled screenshot or log artifact for a test case — run the Evidence subagent standalone.
argument-hint: <feature-folder> <TC-ID(s)>
---

Use the Task tool to invoke the `evidence` subagent (defined in `.claude/agents/evidence.md`) with the following task, verbatim:

$ARGUMENTS

When it returns, relay the labelled artifacts (EVD-*) unmodified. Do not interpret them or assign PASS/FAIL — that is the QA Engineer's job.

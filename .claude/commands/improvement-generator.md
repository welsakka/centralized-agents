---
description: Analyze a just-shipped feature cycle and generate exactly one evidence-backed improvement prompt sized for the next sdlc-orchestrator cycle.
argument-hint: <feature-folder path> <base-sha>..<head-sha>
---

Use the Task tool to invoke the `improvement-generator` subagent (defined in `.claude/agents/improvement-generator.md`) with the following task, verbatim:

$ARGUMENTS

When it returns, present its full response (candidates considered, the one improvement prompt, evidence, and sizing justification) to the human. Do not begin implementation yourself — the generated prompt is meant to be handed to `/sdlc-orchestrator` as a new cycle's input, with human review in between, unless the human has explicitly authorized an autonomous improvement loop (see `docs/knowledge/improvement-loop.md`).

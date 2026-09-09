# Agent Docs Index

All documentation is organized into three layers. **Start with the knowledge base.**

---

## Layer 1 — Knowledge base (living, always current)

| File | Read when |
|---|---|
| [knowledge/_schema.md](knowledge/_schema.md) | Before writing anything to `docs/knowledge/` — defines exact formats, numbering, and the verification checklist |
| [knowledge/primer.md](knowledge/primer.md) | Starting any session — 1-page codebase snapshot |
| [knowledge/pitfalls.md](knowledge/pitfalls.md) | Before touching a known problem area |
| [knowledge/patterns.md](knowledge/patterns.md) | Before implementing something new |
| [knowledge/integrations/](knowledge/integrations/) | Per-service reference files — one per external service |
| [knowledge/improvement-loop.md](knowledge/improvement-loop.md) | Before chaining multiple `sdlc-orchestrator` cycles autonomously |

---

## Layer 2 — Feature history (per-feature SDLC artifacts)

| # | Feature | Design | Dev Log | QA |
|---|---|---|---|---|
| — | *(no features yet — rows added by Architect agent)* | — | — | — |

---

## SDLC agents and slash commands

Role definitions live in `.claude/agents/` (with enforced tool restrictions); the slash commands in `.claude/commands/` are thin entry points that delegate to them via the Task tool.

| Command | Subagent | Purpose |
|---|---|---|
| `/sdlc-orchestrator <feature>` | — (orchestrates all) | Full pipeline: Triage → Architect → human approval → Senior Engineer → QA (bounded repair loop) → Docs Manager |
| `/architect <feature>` | `architect` | Design doc with testable acceptance criteria |
| `/senior-engineer <feature-folder>` | `senior-engineer` | Test-first implementation + dev log |
| `/qa-engineer <feature-folder>` | `qa-engineer` | Executable QA tests + PASS/FAIL handoff |
| `/evidence <TC-ID>` | `evidence` | Screenshot/log artifact collector (read-only) |
| `/docs-manager <task>` | `docs-manager` | Knowledge synthesis, as-implemented, AGENTS.md updates |
| `/improvement-generator <feature-folder> <sha-range>` | `improvement-generator` | Reads a shipped cycle, produces one evidence-backed improvement prompt for the next cycle |

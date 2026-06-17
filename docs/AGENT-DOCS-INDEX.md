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

---

## Layer 2 — Feature history (per-feature SDLC artifacts)

| # | Feature | Design | Dev Log | QA |
|---|---|---|---|---|
| — | *(no features yet — rows added by Architect agent)* | — | — | — |

---

## SDLC slash commands

| Command | Purpose |
|---|---|
| `/sdlc-orchestrator <feature>` | Full pipeline: Architect → human approval → Senior Engineer → QA → Docs Manager |
| `/architect <feature>` | Design doc + ADR only |
| `/senior-engineer <feature-folder>` | Implement + write dev log |
| `/qa-engineer <feature-folder>` | Test cases + QA handoff |
| `/evidence <TC-ID>` | Screenshot/log artifact collector |
| `/docs-manager <task>` | Knowledge synthesis, as-implemented, AGENTS.md updates |

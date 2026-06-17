# centralized-agents

Reusable SDLC agent infrastructure for Claude Code projects. Drop this into any repo and get a full Architect → Engineer → QA → Docs pipeline out of the box.

---

## What's in here

```
.claude/commands/          Six slash commands (see below)
docs/
  AGENT-DOCS-INDEX.md      Master index — agents start here
  knowledge/
    _schema.md             Format contracts for every knowledge file
    primer.md              Template: 1-page codebase snapshot (fill in per project)
    pitfalls.md            Stub: cross-feature gotchas (Docs Manager fills this)
    patterns.md            Stub: recurring code patterns (Docs Manager fills this)
    integrations/          One .md per external service (created by Docs Manager)
  features/                One folder per feature: design, dev log, QA handoff
AGENTS.md                  Two-liner agents read on every session start
bootstrap.sh               Non-destructive copy script
```

---

## The pipeline

```
/sdlc-orchestrator <feature description>
        │
        ▼
  [1] architect        → docs/features/<NNN>/01-design.md
        │
        ▼  (human approves)
        │
        ▼
  [3] senior-engineer  → implementation + docs/features/<NNN>/02-dev-log.md
        │
        ▼
  [4] qa-engineer      → docs/features/<NNN>/03-qa.md  (PASS/FAIL)
        │                 if FAIL → back to senior-engineer
        ▼
  [5] docs-manager     → merges pitfalls, patterns, primer, integrations
        │
        ▼
     ACHIEVED
```

Each step maps to a slash command you can also call standalone:

| Command | When to use standalone |
|---|---|
| `/architect <feature>` | Design-only spike before committing to implementation |
| `/senior-engineer <feature-folder>` | Re-run after a QA FAIL |
| `/qa-engineer <feature-folder>` | Re-test after a hotfix |
| `/evidence <TC-ID>` | Collect a screenshot or log for a specific test case |
| `/docs-manager <task>` | Synthesize knowledge after an out-of-band fix |

---

## How to bootstrap a new project

```bash
# From the target repo root:
bash /path/to/centralized-agents/bootstrap.sh .
```

The script copies all infrastructure files. It is non-destructive — it skips any file that already exists, so re-running it is safe.

After bootstrapping:
1. Fill in `docs/knowledge/primer.md` with your project's tech stack, DB schema, routes, and coding rules.
2. Update `AGENTS.md` if you have project-specific notes agents must read on every session.
3. Run `/sdlc-orchestrator <your first feature>` to kick off the pipeline.

---

## Knowledge base maintenance contract

All knowledge files follow exact formats defined in `docs/knowledge/_schema.md`. Do not add entries to `pitfalls.md`, `patterns.md`, or `integrations/` by hand — the Docs Manager agent owns those after each feature cycle. Edit `primer.md` when the stack, schema, or routes change.

---

## Source

Infrastructure originally extracted from [welsakka/Muslim-Finance-OS](https://github.com/welsakka/Muslim-Finance-OS). Command files and schema are project-agnostic; `primer.md`, `pitfalls.md`, and `patterns.md` are blank templates you populate per project.

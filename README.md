# centralized-agents

Reusable SDLC agent infrastructure for Claude Code projects. Drop this into any repo and get a full Triage → Architect → Engineer → QA → Docs pipeline out of the box — with tests as the first-class deliverable at every stage.

---

## What's in here

```
.claude/
  agents/                  Five subagents with enforced tool restrictions
    architect.md             designs; writes docs only
    senior-engineer.md       implements test-first
    qa-engineer.md           verifies with executable tests; never touches prod code
    docs-manager.md          synthesizes knowledge; docs only
    evidence.md              collects artifacts; no write tools at all
  commands/                Six slash commands — thin entry points that delegate
                           to the subagents via the Task tool
docs/
  AGENT-DOCS-INDEX.md      Master index — agents start here
  knowledge/
    _schema.md             Format contracts + pruning rules for every knowledge file
    primer.md              Template: 1-page codebase snapshot (fill in per project)
    pitfalls.md            Stub: cross-feature gotchas (Docs Manager fills this)
    patterns.md            Stub: recurring code patterns (Docs Manager fills this)
    integrations/          One .md per external service (created by Docs Manager)
  features/                One folder per feature: design, dev log, QA handoff
AGENTS.md                  Engineering rules agents read on every session start
bootstrap.sh               Non-destructive copy script
```

The role definitions live in `.claude/agents/` so the orchestrator can delegate to them with the Task tool and so each role's constraints are **enforced by its `tools:` list**, not just requested in prose. The slash commands are thin wrappers around the same agents, so there is a single source of truth per role.

---

## The pipeline

```
/sdlc-orchestrator <feature description>
        │
        ▼
  [0] triage           → full track, or fast track (small fixes skip design)
        │
        ▼
  [1] architect        → docs/features/<NNN>/01-design.md
        │                 (incl. testable acceptance criteria AC-1, AC-2, …)
        ▼
  [2] human approval gate
        │
        ▼
  [3] senior-engineer  → failing test per AC, then implementation
        │                 + docs/features/<NNN>/02-dev-log.md
        ▼
  [4] qa-engineer      → executable tests committed to the repo
        │                 + docs/features/<NNN>/03-qa.md  (PASS/FAIL)
        │
        │  FAIL → auto-return to [3], at most twice,
        │         then escalate to the human
        ▼
  [5] docs-manager     → merges pitfalls, patterns, primer, integrations
        │
        ▼
     ACHIEVED
```

What makes this testing-first in practice, not just in name:

- The design doc's **acceptance criteria are testable statements**; the engineer writes a failing test per criterion before implementing, and the Definition of Done requires the full suite green — lint + build alone don't cut it.
- **QA test cases are committed test files**, named after their TC-IDs, so every feature cycle permanently grows the regression suite instead of leaving a markdown table behind.
- The QA→Engineer **repair loop is bounded**: two automatic iterations, then human escalation with the full findings history.

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
1. Fill in `docs/knowledge/primer.md` with your project's tech stack, DB schema, routes, test command, and coding rules.
2. Update `AGENTS.md` if you have project-specific notes agents must read on every session.
3. Optionally wire up an enforcement hook (below).
4. Run `/sdlc-orchestrator <your first feature>` to kick off the pipeline.

---

## Enforcement hooks (recommended)

Agent instructions are requests; hooks are guarantees. To make a red suite mechanically block completion, add a `Stop` hook to the target repo's `.claude/settings.json` with your project's real commands:

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "npm run lint && npm test"
          }
        ]
      }
    ]
  }
}
```

This isn't copied by `bootstrap.sh` because the commands are project-specific — set it up once per project. See the [Claude Code hooks docs](https://code.claude.com/docs/en/hooks) for details.

---

## Knowledge base maintenance contract

All knowledge files follow exact formats defined in `docs/knowledge/_schema.md`, including a pruning rule that keeps `pitfalls.md` from growing unboundedly. Do not add entries to `pitfalls.md`, `patterns.md`, or `integrations/` by hand — the Docs Manager agent owns those after each feature cycle. Edit `primer.md` when the stack, schema, or routes change.

---

## Source

Infrastructure originally extracted from [welsakka/Muslim-Finance-OS](https://github.com/welsakka/Muslim-Finance-OS). Agent files, command files, and schema are project-agnostic; `primer.md`, `pitfalls.md`, and `patterns.md` are blank templates you populate per project.

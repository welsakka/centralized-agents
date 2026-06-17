# Knowledge Base Schema

> **This file tells agents exactly how to maintain `docs/knowledge/`.** Read it before adding or updating any knowledge file. Do not improvise format — follow the templates here exactly.

---

## File responsibilities

| File | Contains | Does NOT contain |
|---|---|---|
| `primer.md` | Current stack, DB schema, services, top 5 gotchas, feature count, next feature number | Historical context, implementation details, per-feature notes |
| `pitfalls.md` | Problems that already burned someone — indexed so the next agent can find them fast | Design decisions, "how to" guides, general advice |
| `patterns.md` | Recurring code patterns specific to this codebase | General programming advice, framework documentation |
| `integrations/<service>.md` | Everything about one external service *as wired into this project* | Generic service documentation (link to official docs instead) |

---

## How to add a pitfall (`pitfalls.md`)

A pitfall qualifies if it comes from a dev log `P-*` entry, caused a real failure, and would not be obvious to a competent engineer unfamiliar with this specific codebase.

**Find the right area section** (or create one if the area doesn't exist):
- `## Database / Supabase`
- `## Auth`
- `## Frontend / React`
- `## <ServiceName>` (add new sections as needed)

**Entry format — copy exactly:**
```markdown
### P-<AREA>-<NNN> — <short title>
**Source:** Feature <NNN> (P-<NNN> in dev log)
**Situation:** <one sentence — when does this happen?>
**What breaks:** <one sentence — what goes wrong?>
**Fix:** <concrete fix, with code reference if applicable>
```

**Numbering:** `P-DB-001`, `P-DB-002`, `P-FE-001`, `P-PLAID-001`, etc. Continue from the highest existing number in that area. Never reuse a number.

**What does NOT go in pitfalls:**
- Design decisions (document the "why" as a `D-*` entry in the dev log instead; pattern-worthy decisions go in `patterns.md`)
- "Best practices" without a specific failure story
- Items already covered by a pitfall entry (just reference the existing one)

---

## How to add a pattern (`patterns.md`)

A pattern qualifies if it appears in more than one feature, represents a non-obvious codebase convention, and deviating from it would cause a bug or style inconsistency.

Patterns come from:
- `D-*` decisions in a dev log that establish a convention
- Code review observations
- Recurring structures spotted across multiple files

**Entry format:**
```markdown
## <Pattern Name>

<One sentence describing when to use this pattern>

```<language>
// code example
```

**Rules:**
- <rule 1>
- <rule 2>
```

**What does NOT go in patterns:**
- One-off implementations
- Framework defaults (link to framework docs instead)
- Anything already in AGENTS.md §3

---

## How to add an integration file (`integrations/<service>.md`)

Create `integrations/<kebab-case-service-name>.md` when a new external service is added to the project.

**Required sections — use these headings exactly:**

```markdown
# Integration: <Service Name>

> One-sentence description of what this service does in this project.
> See also: any relevant feature folders in `docs/features/`.

---

## How it works
<Describe the integration flow as it exists in this codebase — not how the service works in general>

## API routes / entry points
<Table or list of where this service is called from>

## Environment variables
| Variable | Purpose | Required |
|---|---|---|
| `VAR_NAME` | ... | Yes / No |

## Key rules
- <rule specific to how this project uses the service>
- <another rule>

## Known issues / production hardening
<Open findings from QA, things not yet done>
```

**What does NOT go in integration files:**
- Generic service documentation (link to official docs)
- Features that don't use the service
- Pricing or account management info

---

## How to update `primer.md`

Update `primer.md` when any of these change:

| What changed | Section to update |
|---|---|
| New table added to DB | `## Current database schema` table |
| Table column added/removed | `## Current database schema` table |
| New external service added | `## External services wired in` table |
| New app route added | `## App routes` table |
| New gotcha discovered | `## Top 5 gotchas` list (keep to 5 — promote most important, drop stale ones) |
| Feature completed | `## Feature history` table + `Next feature number` line |

**Do not rewrite primer.md from scratch.** Make targeted edits to the specific sections that changed. The file should always be readable in under 2 minutes.

---

## Verification checklist for `/docs-manager` after every feature

After synthesizing a dev log, confirm each item before committing:

- [ ] Every `P-*` item in `02-dev-log.md` → added to `pitfalls.md` (or note why it doesn't qualify)
- [ ] Every `D-*` item in `02-dev-log.md` → evaluated: new pattern? (→ `patterns.md`) integration-specific? (→ `integrations/<service>.md`) already documented? (→ skip)
- [ ] Any new service introduced → `integrations/<service>.md` created
- [ ] DB schema changed → `primer.md` schema table updated
- [ ] Feature completed → `primer.md` feature history table + next feature number updated
- [ ] Any deviations from design → `01-design.md` "As Implemented" section prepended
- [ ] `primer.md` feature history table → new row added, next feature number updated

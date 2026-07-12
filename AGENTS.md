# Agent Instructions

Read `docs/knowledge/primer.md` before any work — it contains the full codebase snapshot, coding conventions, commit format, and approval requirements.
SDLC subagents live in `.claude/agents/`; the slash commands in `.claude/commands/` are thin entry points that delegate to them. Full docs index: `docs/AGENT-DOCS-INDEX.md`.

---

# Engineering Rules

These rules are enforced by the pipeline itself — the Senior Engineer's Definition of Done, the QA Engineer's sign-off checklist, and the subagents' tool restrictions — not by this prose alone. Keep them few and keep them checkable.

**1. Tests are the deliverable.**
Every behavior change ships with an executable test committed alongside it, and every acceptance criterion in a design doc maps to at least one test. The full suite must be green before any handoff. A change without a test is not done; a test that ran once in a chat window and was never committed does not count.

**2. Never weaken the suite to get green.**
Do not delete, skip, or loosen an existing test to make it pass. A legitimately obsolete test may be updated, with the reason recorded as a `D-*` entry in the dev log.

**3. Validate at the boundaries, type everything.**
Validate all external input (user input, API responses, webhook payloads) at system boundaries with schema validation. Use strict static typing (TypeScript strict mode, Python type hints). Never trust external data.

**4. No invented APIs.**
Do not guess method signatures, library APIs, or config keys. Verify against the codebase or official docs; if you cannot verify, leave a `TODO: VERIFY` comment rather than plausible-looking fiction.

**5. No silent failures.**
Errors are handled or propagated with context — never swallowed. Log descriptive, contextual errors. Add retries/timeouts to external calls where the failure mode warrants it, not as ritual.

**6. No secrets in code or client bundles.**
Never hardcode credentials; never expose server-side keys to the client. Sanitize queries (no SQLi), encode outputs (no XSS).

**7. Human approval before the irreversible.**
Schema changes, new packages, auth changes, and new env vars require explicit human approval before implementation (see primer.md "Human approval required before"). Never treat them as pre-approved.

---

# Enforcement

Prefer mechanical gates over instructions:
- Subagent `tools:` lists in `.claude/agents/` restrict what each role can touch (e.g. the Evidence agent has no write tools; the orchestrator command is Task-only).
- Wire lint + tests into a Claude Code hook so a red suite blocks completion regardless of what any agent claims — see the "Enforcement hooks" section of the README.

# Codebase Primer

> **For agents:** Read this before touching any code. It covers codebase state, coding conventions, commit format, and approval requirements — everything you need. For known gotchas, see `docs/knowledge/pitfalls.md`. For deep dives on specific features, see `docs/features/`.

---

## What this project is

<!-- One-paragraph description: what the product does, who it's for, what makes it distinctive. -->

---

## Tech stack

| Layer | Technology | Version |
|---|---|---|
| <!-- e.g. Framework --> | <!-- e.g. Next.js App Router --> | <!-- e.g. 14.x --> |

Dev server: <!-- command and URL, e.g. `npm run dev` → `http://localhost:3000` -->

---

## Current database schema

| Table | Purpose | Key columns |
|---|---|---|
| <!-- table_name --> | <!-- purpose --> | <!-- col1, col2 --> |

---

## External services wired in

| Service | Purpose | Env vars | Docs |
|---|---|---|---|
| <!-- ServiceName --> | <!-- purpose --> | <!-- VAR_NAME --> | <!-- link or — --> |

---

## App routes

| Route | What it is |
|---|---|
| `/` | <!-- description --> |

---

## Top 5 gotchas

1. <!-- Most important codebase-specific gotcha -->
2.
3.
4.
5.

---

## Feature history (numbered)

| # | Feature | Status |
|---|---|---|
| — | *(no features yet)* | — |

Next feature number: **001**

---

## Folder structure

```
<!-- paste directory tree here -->
```

<!-- Add any layout rules that agents must follow (e.g. "never put business logic in app/") -->

---

## Coding rules

- <!-- TypeScript strict, linting rules, etc. -->

---

## Commit format

```
<type>(<scope>): <short imperative summary>
```

Types: <!-- e.g. feat · fix · docs · refactor · chore -->
Scopes: <!-- e.g. api · ui · lib · docs · config -->

---

## Human approval required before

- <!-- e.g. DB schema changes, new packages, auth changes, new env vars, deleting files, pushing to main -->

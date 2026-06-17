#!/usr/bin/env bash
# bootstrap.sh — copy centralized-agents SDLC infrastructure into a target repo.
# Non-destructive: skips any file that already exists in the target.
# Usage: bash bootstrap.sh /path/to/target-repo

set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="${1:-}"

if [[ -z "$DEST" ]]; then
  echo "Usage: bash bootstrap.sh /path/to/target-repo"
  exit 1
fi

if [[ ! -d "$DEST" ]]; then
  echo "Error: target directory '$DEST' does not exist."
  exit 1
fi

copy_if_missing() {
  local src="$1"
  local dest="$2"
  if [[ -e "$dest" ]]; then
    echo "  SKIP  $dest  (already exists)"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  COPY  $dest"
  fi
}

echo "Bootstrapping SDLC infrastructure into: $DEST"
echo ""

# --- Slash commands ---
echo ">>> .claude/commands/"
for f in "$SRC/.claude/commands/"*.md; do
  fname="$(basename "$f")"
  copy_if_missing "$f" "$DEST/.claude/commands/$fname"
done

# --- Knowledge base infrastructure ---
echo ">>> docs/knowledge/"
copy_if_missing "$SRC/docs/knowledge/_schema.md"    "$DEST/docs/knowledge/_schema.md"
copy_if_missing "$SRC/docs/knowledge/primer.md"     "$DEST/docs/knowledge/primer.md"
copy_if_missing "$SRC/docs/knowledge/pitfalls.md"   "$DEST/docs/knowledge/pitfalls.md"
copy_if_missing "$SRC/docs/knowledge/patterns.md"   "$DEST/docs/knowledge/patterns.md"

# --- Placeholder directories ---
mkdir -p "$DEST/docs/features"
mkdir -p "$DEST/docs/knowledge/integrations"

# --- Top-level docs ---
echo ">>> docs/"
copy_if_missing "$SRC/docs/AGENT-DOCS-INDEX.md" "$DEST/docs/AGENT-DOCS-INDEX.md"

# --- AGENTS.md ---
echo ">>> AGENTS.md"
copy_if_missing "$SRC/AGENTS.md" "$DEST/AGENTS.md"

echo ""
echo "Done. Next steps:"
echo "  1. Fill in docs/knowledge/primer.md with your project's stack and conventions."
echo "  2. Update AGENTS.md with any project-specific rules."
echo "  3. Run /sdlc-orchestrator <feature-name> to start your first feature cycle."

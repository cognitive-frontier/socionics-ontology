#!/usr/bin/env bash
# deploy.sh — one-shot push for the Ontology of Socionics site.
#
# Usage:
#   ./deploy.sh <github-username> <repo-name> [commit-message]
#
# Prereqs (one-time):
#   1. You have git installed.
#   2. You have already created an EMPTY repo on GitHub with the name you pass as <repo-name>.
#      (Do NOT initialize it with a README or .gitignore — this script adds those.)
#   3. You are authenticated with GitHub on this machine. The simplest path is the
#      GitHub CLI (`gh auth login`) which handles credentials for HTTPS pushes.
#      Alternatively, a personal access token stored via git's credential helper works.
#
# What this script does:
#   - Initializes a git repo here if one doesn't already exist
#   - Stages all files, commits them
#   - Sets the remote to your repo (or updates it if already set)
#   - Pushes to `main`
#
# After it succeeds:
#   Go to https://github.com/<username>/<repo-name>/settings/pages
#   Set source to "Deploy from a branch", branch `main`, folder `/ (root)`, save.
#   The site will be live at https://<username>.github.io/<repo-name>/ within ~1 minute.

set -euo pipefail

# ---- Arg parsing ----
if [ "$#" -lt 2 ]; then
  echo "Usage: ./deploy.sh <github-username> <repo-name> [commit-message]"
  echo "Example: ./deploy.sh yon-writes socionics-ontology"
  exit 1
fi

USERNAME="$1"
REPO="$2"
MSG="${3:-Initial site}"
REMOTE_URL="https://github.com/${USERNAME}/${REPO}.git"

# ---- Sanity checks ----
if ! command -v git >/dev/null 2>&1; then
  echo "Error: git is not installed. Install it from https://git-scm.com/ and try again."
  exit 1
fi

if [ ! -f "index.html" ]; then
  echo "Error: no index.html in the current directory."
  echo "Run this script from the folder where you unzipped the site files."
  exit 1
fi

# ---- Git init (idempotent) ----
if [ ! -d ".git" ]; then
  echo "→ Initializing git repo..."
  git init -q
  git branch -M main
fi

# ---- Stage + commit ----
echo "→ Staging files..."
git add .

if git diff --cached --quiet; then
  echo "→ No changes to commit. Proceeding to push."
else
  echo "→ Committing: \"$MSG\""
  git commit -q -m "$MSG"
fi

# ---- Remote setup (idempotent) ----
if git remote get-url origin >/dev/null 2>&1; then
  CURRENT=$(git remote get-url origin)
  if [ "$CURRENT" != "$REMOTE_URL" ]; then
    echo "→ Updating remote origin to $REMOTE_URL"
    git remote set-url origin "$REMOTE_URL"
  fi
else
  echo "→ Adding remote origin: $REMOTE_URL"
  git remote add origin "$REMOTE_URL"
fi

# ---- Push ----
echo "→ Pushing to main..."
git push -u origin main

echo
echo "✓ Done."
echo
echo "Next: enable GitHub Pages."
echo "  1. Open:  https://github.com/${USERNAME}/${REPO}/settings/pages"
echo "  2. Source: Deploy from a branch"
echo "  3. Branch: main   /   Folder: / (root)   →   Save"
echo "  4. Wait ~1 minute, then visit:"
echo "       https://${USERNAME}.github.io/${REPO}/"

#!/usr/bin/env bash
# Archives tutorial/fork/low-signal public repos. Requires a PAT with repo scope.
# Usage: GH_TOKEN=ghp_... ./scripts/archive-low-signal-repos.sh

set -euo pipefail
: "${GH_TOKEN:?Set GH_TOKEN to a GitHub personal access token}"

OWNER="SurajG20"
REPOS=(
  examples
  next-saas-starter
  shortcuts
  safer-python-api
  Odin-Recipes
  Landing-Page
  Analog-Clock
  Calculator
  etch-a-sketch
  Rock-Paper-Scissor
  To-Do-App
  Weather-App
  SHOPI-Q
  Stratgeek-internship
  Finmart
  LiumGo
  Chatify
  Ecommerce-Website
  Expense-Tracker
  Leetcode-Solutions
)

for name in "${REPOS[@]}"; do
  echo "Archiving ${OWNER}/${name}..."
  curl -sS -X PATCH \
    -H "Authorization: Bearer ${GH_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${OWNER}/${name}" \
    -d '{"archived":true}' \
    | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('full_name', d.get('message','?')))"
done

echo "Done. Review remaining public repos at https://github.com/${OWNER}?tab=repositories"

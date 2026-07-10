#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "==> Setting up project in $ROOT_DIR"

if ! command -v go >/dev/null 2>&1; then
  echo "❌ Go is not installed. Install Go 1.22+ first." >&2
  exit 1
fi

if [ ! -f lefthook.yml ]; then
  echo "❌ lefthook.yml not found. Run this script from the project root." >&2
  exit 1
fi

echo "==> Downloading Go modules"
go mod download

if ! command -v lefthook >/dev/null 2>&1; then
  echo "❌ Lefthook is not installed." >&2
  echo "   Install with one of:" >&2
  echo "     brew install lefthook" >&2
  echo "     go install github.com/evilmartians/lefthook/v2@latest" >&2
  exit 1
fi

echo "==> Installing Git hooks"
lefthook install

echo "✅ Setup complete. Git hooks are ready."

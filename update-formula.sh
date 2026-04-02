#!/usr/bin/env bash
set -euo pipefail

FORMULA="Formula/kiro-generator.rb"
REPO="kiro-generator/kiro-generator"

NEW_VER=$(nvchecker -c .nvchecker.toml --logger json | jq -r .version)
CUR_VER=$(grep -oP 'download/v\K[0-9]+\.[0-9]+\.[0-9]+' "$FORMULA" | head -1)

NEW_VER="${NEW_VER#v}"

if [[ "$NEW_VER" == "$CUR_VER" ]]; then
  echo "up to date: $CUR_VER"
  exit 0
fi

echo "$CUR_VER -> $NEW_VER"

SUMS=$(curl -sL "https://github.com/${REPO}/releases/download/v${NEW_VER}/SHA256SUMS")
SHA256=$(awk '/kg-arm64-darwin\.tar\.gz/ {print $1}' <<< "$SUMS")

sed -i "s|v${CUR_VER}/kg-arm64-darwin|v${NEW_VER}/kg-arm64-darwin|" "$FORMULA"
sed -i "s|sha256 \"[a-f0-9]*\"|sha256 \"${SHA256}\"|" "$FORMULA"

echo "updated to $NEW_VER (sha256: $SHA256)"

[[ -n "${CI:-}" ]] && echo "version=${NEW_VER}" >> "$GITHUB_OUTPUT"

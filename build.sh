#!/bin/sh
# Builds dist/levi.css (one file) and dist/levi.min.css (no comments, no blank lines).
# levi.css lists the components as @import lines; each one is replaced by its file, in the same order.
set -e
cd "$(dirname "$0")"
mkdir -p dist
sed -n 's/^@import url("\(.*\)");$/\1/p' levi.css | while read -r f; do
	cat "$f"
	echo
done > dist/levi.css
awk 'BEGIN{RS="\0"} {gsub(/\/\*[^*]*\*+([^\/*][^*]*\*+)*\//, ""); print}' dist/levi.css | awk 'NF{sub(/^[ \t]+/, ""); sub(/[ \t]+$/, ""); printf "%s ", $0}' > dist/levi.min.css
echo >> dist/levi.min.css
wc -c dist/levi.css dist/levi.min.css

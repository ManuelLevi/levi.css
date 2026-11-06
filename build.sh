#!/bin/sh
# Builds levi.css (the one file users copy) and levi.min.css (no comments, no blank lines) from src/.
# src/index.css lists the components as @import lines; each one is replaced by its file, in the same order.
set -e
cd "$(dirname "$0")"
sed -n 's/^@import url("\(.*\)");$/\1/p' src/index.css | while read -r f; do
	cat "src/$f"
	echo
done > levi.css
awk 'BEGIN{RS="\0"} {gsub(/\/\*[^*]*\*+([^\/*][^*]*\*+)*\//, ""); print}' levi.css | awk 'NF{sub(/^[ \t]+/, ""); sub(/[ \t]+$/, ""); printf "%s ", $0}' > levi.min.css
echo >> levi.min.css

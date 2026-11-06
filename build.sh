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
# icons.svg: one <symbol> per file in src/icons, used as <svg class="mc-icon"><use href="icons.svg#name"/></svg>
{
	echo '<!-- Lucide icons, ISC license: see src/icons/LICENSE -->'
	echo '<svg xmlns="http://www.w3.org/2000/svg">'
	for f in src/icons/*.svg; do
		n=$(basename "$f" .svg)
		printf '<symbol id="%s" viewBox="0 0 24 24">' "$n"
		awk 'BEGIN{RS="\0"} {gsub(/<!--[^>]*-->/, ""); sub(/^[ \t\r\n]*<svg[^>]*>/, ""); sub(/<\/svg>[ \t\r\n]*$/, ""); gsub(/[ \t]*\r?\n[ \t]*/, ""); printf "%s", $0}' "$f"
		echo '</symbol>'
	done
	echo '</svg>'
} > icons.svg

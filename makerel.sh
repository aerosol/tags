#!/usr/bin/env bash
UTC_NOW=$(date +'%y.%m.%d' -u)
LAST=$(git describe --match "r/[0-9\.]*" --tags --abbrev=0 HEAD) || echo "r/$UTC_NOW/0"
echo "Last: $LAST"
IFS=/ read -r R_CHAR R_DATE R_SEQ <<< $LAST
NEW_SEQ=$((R_SEQ+1))
NEW_REL="r/$UTC_NOW/$NEW_SEQ"
git add log.txt
echo "This is release $NEW_REL" >> log.txt
git commit . -m "Releasing $NEW_REL"
git tag $NEW_REL
git push origin main --tags

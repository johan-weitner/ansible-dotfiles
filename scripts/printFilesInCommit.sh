#!/bin/bash

echo "\n\nCURRENT BRANCH: $(git branch --show-current)"
echo "\nCOMMIT MESSAGE:"
git show -s --format=%s HEAD | cat
echo --------------------------------------------------------------------------------
echo "FILES CHANGED IN COMMIT:"
git diff-tree --no-commit-id --name-only -r -M HEAD | cat

#!/bin/bash

echo "Enter commit hash of commit you want to move: "
read commitToMove
echo ""
echo "Enter commit hash of commit you want to move behind: "
read targetCommit
echo ""
git rebase --onto "$targetCommit" "$commitToMove"
echo ""
echo "Working..."
echo ""
echo "Done!"
echo ""
git log --oneline | cat
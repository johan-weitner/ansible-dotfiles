#!/bin/bash

# Define source directory and target directory
source_dir=$(pwd)
parent_dir=$(dirname $(pwd))
target_dir=$parent_dir/temp/
current_branch=$(git branch --show-current)

echo "\nBacking up files in latest commit to $target_dir"
echo "\nCurrent branch: $current_branch"
echo "Latest commit: $(git rev-parse $current_branch)"
echo "Commit message: $(git show -s --format=%s HEAD | cat)"

git diff-tree --no-commit-id --name-only -r -M HEAD > list.txt

# Read the list of files (one file per line) from a file (e.g., "list.txt")
while read -r file; do
    # Get the relative path of the file (remove the source directory prefix)
    relative_path="${file#$source_dir}"

    # Construct the target path by appending the relative path to the target directory
    target_path="$target_dir$relative_path"

    # Create the necessary subdirectories in the target directory
    mkdir -p "$(dirname "$target_path")"

    # Copy the file to the target directory
    cp "$file" "$target_path"
done < "list.txt"

mv list.txt "$target_dir"

echo "\nDone! Files in latest commit backed up to $target_dir"





# # To call copyChangedFiles from the command line:
# ./copyChangedFiles.sh

# # To call copyFilesBack from the command line:  
# ./copyChangedFiles.sh copyFilesBack

# copy_changed_files() {
#   source_dir=$(pwd)
#   parent_dir=$(dirname $(pwd))
#   target_dir=$parent_dir/temp/

#   git diff-tree --no-commit-id --name-only -r -M HEAD > list.txt

#   while read -r file; do
#     relative_path="${file#$source_dir}"
#     target_path="$target_dir$relative_path"
#     mkdir -p "$(dirname "$target_path")"
#     cp "$file" "$target_path" 
#   done < "list.txt"

#   rm -f list.txt

#   echo "Files copied with directory structure intact!"
# }

# copy_files_back() {
#   target_dir=$parent_dir/temp/
#   source_dir=$(pwd)

#   for file in "$target_dir"*; do
#     relative_path="${file#$target_dir}"
#     source_path="$source_dir$relative_path" 
#     cp "$file" "$source_path"
#   done

#   rm -rf "$target_dir"

#   echo "Files copied back from temp directory"
# }

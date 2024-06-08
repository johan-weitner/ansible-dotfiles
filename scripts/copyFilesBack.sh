#!/bin/bash

# Define source and target directories
parent_dir=$(dirname $(pwd))
target_dir=$parent_dir/temp/
source_dir=$(pwd)/
current_branch=$(git branch --show-current)

echo "\nRestoring files from backed up commit"
echo "\nCurrent branch: $current_branch"

# Loop through all files in target directory
while read -r file; do
  # Get relative path
  relative_path="${file#$target_dir}"
  
  # Construct source path 
  source_path="$source_dir$relative_path"

  echo "\nCopying $file to $source_path"
  
  # Copy file back to source
  cp "$file" "$source_path" 
done < "../temp/list.txt"

# Delete temp directory
rm -rf "$target_dir"

echo "\nRemoved temp directory"
echo "\nDone! Files copied back from temp directory"
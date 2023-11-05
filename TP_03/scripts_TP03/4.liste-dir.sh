#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <répertoire>"
  exit 1
fi

directory="$1"

if [ ! -d "$directory" ]; then
  echo "Le répertoire spécifié n'existe pas."
  exit 1
fi

echo "####### fichiers dans $directory/"
for file in "$directory"/*; do
  if [ -f "$file" ]; then
    echo "$file"
  fi
done

echo "####### répertoires dans $directory/"
for subdir in "$directory"/*; do
  if [ -d "$subdir" ]; then
    echo "$subdir"
  fi
done

#!/bin/bash

# Verification du nombre de paramètres
if [ $# -ne 1 ]; then
  echo "Usage: $0 <répertoire>"
  exit 1
fi

directory="$1"

# Verification de l'existence du répertoire
if [ ! -d "$directory" ]; then
  echo "Le répertoire spécifié n'existe pas."
  exit 1
fi

# Parcours du répertoire et affichage des fichiers et répertoires
echo "####### fichiers dans $directory/"
for file in "$directory"/*; do
  if [ -f "$file" ]; then
    echo "$file"
  fi
done

# Parcours du répertoire et affichage des répertoires
echo "####### répertoires dans $directory/"
for subdir in "$directory"/*; do
  if [ -d "$subdir" ]; then
    echo "$subdir"
  fi
done
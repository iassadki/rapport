#!/bin/bash
param_count=$#
script_name=$0
param_3=$3
param_list=("$@")

echo "Bonjour, vous avez rentré $param_count paramètres."
echo "Le nom du script est $script_name."
echo "Le 3ème paramètre est $param_3."
echo "Voici la liste des paramètres : ${param_list[@]}"


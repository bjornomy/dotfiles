#!/bin/bash

echo "GOT: $1"
aliasName=$(echo $1 | awk '{ split($2, a, "="); print a[1] ".fish" }')
echo "PARSED: $aliasName"

echo $1 > $HOME/.config/fish/functions/$aliasName

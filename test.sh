#! /bin/bash

set -euo pipefail
rm -rf dist;

#if [[ $(docker images | grep tape-run >/dev/null ; echo $?) -eq 1 ]]; then
   #docker build -t tape-run .
#fi

list_input=$(find ./test -iname "*.spec.js")
list_output=$(find ./test -iname "*.spec.js" -exec basename  {} \; | awk '{print "./dist/"$0}')

function processFile() {
  #webpack $1 $2 >/dev/null && cat $2 | docker run --rm -i tape-run
  webpack $1 $2 >/dev/null && cat $2 | tape-run
}

export -f processFile

parallel -j4 processFile ::: "${list_input[@]}" ::: "${list_output[@]}"


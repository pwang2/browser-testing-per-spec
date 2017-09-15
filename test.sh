#! /bin/bash

set -euo pipefail
rm -rf dist;

hasimg=$(docker images | grep tape-run >/dev/null ; echo $?)
if [[ $hasimg -eq 1 ]]; then
  docker build -t tape-run .
fi

function processFile() {
  # surprisingly, docker container is faster than local tape-run
  # local chrome will not exist unless call window.close
  #webpack $1 $2>/dev/null && cat $2 | tape-run --browser chrome
  webpack $1 $2>/dev/null && cat $2 | docker run --rm -i  --cap-add SYS_ADMIN tape-run
}

export -f processFile

list_input=$(find ./test -iname "*.spec.js")
list_output=$(echo "$list_input" | xargs -n 1 basename | awk '{print "./dist/"$0}')

paste <(echo "$list_input") <(echo "$list_output") |
parallel -j4 --colsep '\t' processFile {1} {2}


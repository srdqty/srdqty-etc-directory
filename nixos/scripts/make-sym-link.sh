#!/usr/bin/env bash

set -eu
set -o noclobber

PREFIX_PATH=$1
RELATIVE_PATH=$2

OUTPUT_PATH="${PREFIX_PATH}/${RELATIVE_PATH}"

timestamp() {
  date +"%s"
}

if test -f "${OUTPUT_PATH}"
then
  echo "${OUTPUT_PATH} exists! Backing up..."
  mv ${OUTPUT_PATH} ${OUTPUT_PATH}.$(timestamp).bak
else
  mkdir -p "$(dirname  ${OUTPUT_PATH})"
fi

ln -s "$(pwd)/${RELATIVE_PATH}" ${OUTPUT_PATH}

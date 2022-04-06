#!/bin/sh

RESULT_FILE="/tmp/test.txt"

function postprocess() {
  echo echo "=== test end." >> "${RESULT_FILE}"
  exit 0
}

trap 'postprocess' 1 2 3 15

# Main
echo "=== test start." >> "${RESULT_FILE}"
while true;
do
  date '+%Y/%m/%d %H:%M:%S' >> "${RESULT_FILE}"
  sleep 1
done

exit 0

#!/usr/bin/env bash
set -e
# SETTINGS
################################################################################

MICROWAVE_HOST="http://35.185.105.222"
MICROWAVE_PORT="8989"
MICROWAVE_PATH="/unoconv/pdf"
MICROWAVE_URL="${MICROWAVE_HOST}:${MICROWAVE_PORT}${MICROWAVE_PATH}"

# INPUT PROCESSING
################################################################################
if [ -z "$1" ]; then
  echo -e "Missing filename. Usage:   topdf.sh filename.docx"
  exit 1
fi
FILENAME=$1  # path to file we want to process
filename_noext="${FILENAME%.*}"
ext="${FILENAME##*.}"


echo "Running:"
echo "curl --form file=@\"${FILENAME}\"  ${MICROWAVE_URL}  > ${filename_noext}.pdf"
curl --form file=@"${FILENAME}"  ${MICROWAVE_URL}  >  "${filename_noext}.pdf"

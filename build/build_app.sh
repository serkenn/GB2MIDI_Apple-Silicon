#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${ROOT_DIR}/dist"
APP_NAME="GB2MIDI.app"
SRC_SCRIPT="${ROOT_DIR}/src/GB2MIDI.applescript"
PERL_SCRIPT="${ROOT_DIR}/GB2MIDI.app/Contents/Resources/Scripts/gb2midi.pl"
ICON_FILE="${ROOT_DIR}/GB2MIDI.app/Contents/Resources/droplet.icns"

rm -rf "${OUT_DIR}"
mkdir -p "${OUT_DIR}"

osacompile -o "${OUT_DIR}/${APP_NAME}" "${SRC_SCRIPT}"

RES_DIR="${OUT_DIR}/${APP_NAME}/Contents/Resources"
mkdir -p "${RES_DIR}/Scripts"

cp "${PERL_SCRIPT}" "${RES_DIR}/Scripts/gb2midi.pl"
cp "${ICON_FILE}" "${RES_DIR}/droplet.icns"

/usr/libexec/PlistBuddy -c "Set :CFBundleIconFile droplet" "${OUT_DIR}/${APP_NAME}/Contents/Info.plist" || true

echo "Built ${OUT_DIR}/${APP_NAME}"

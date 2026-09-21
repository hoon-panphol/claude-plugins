#!/usr/bin/env bash
# สร้างไฟล์ .zip จากโฟลเดอร์ใน plugins/portfolio-skills/skills/
# สำหรับคนที่ใช้ Claude Desktop / claude.ai ซึ่งอัปโหลด skill เป็นไฟล์ zip ทีละตัว
# รันใหม่ทุกครั้งที่แก้เนื้อหา skill:  ./scripts/build-skill-zips.sh
set -euo pipefail
cd "$(dirname "$0")/.."
SRC=plugins/portfolio-skills/skills
OUT=dist
rm -f "$OUT"/*.zip
mkdir -p "$OUT"
for dir in "$SRC"/*/; do
  name=$(basename "$dir")
  ( cd "$SRC" && zip -qr -X "../../../$OUT/$name.zip" "$name" \
      -x '*.DS_Store' '._*' '*/._*' )
  echo "  $OUT/$name.zip"
done
echo "เสร็จแล้ว $(ls -1 "$OUT"/*.zip | wc -l) ไฟล์"

#!/bin/bash
# ============================================================
# setup-libs.sh
# يُنشئ مجلد /libs/ ويحمّل فيه:
#   - transformers.min.js
#   - ort-wasm-simd-threaded.wasm
#   - ort-wasm-simd.wasm
#   - ort-wasm.wasm
# من @xenova/transformers@2.17.2
# شغّل هذا السكريبت مرة واحدة قبل النشر
# ============================================================

VERSION="2.17.2"
BASE="https://cdn.jsdelivr.net/npm/@xenova/transformers@${VERSION}/dist"
OUT="libs"

mkdir -p "$OUT"

files=(
  "transformers.min.js"
  "ort-wasm-simd-threaded.wasm"
  "ort-wasm-simd.wasm"
  "ort-wasm.wasm"
  "ort-wasm-threaded.wasm"
)

for f in "${files[@]}"; do
  echo "⬇️  Downloading $f ..."
  curl -L --max-time 120 "${BASE}/${f}" -o "${OUT}/${f}"
  echo "   → $(du -sh ${OUT}/${f} | cut -f1)"
done

echo ""
echo "✅ Done! All files saved to ./${OUT}/"
echo "   Now deploy your project including the /libs/ folder."

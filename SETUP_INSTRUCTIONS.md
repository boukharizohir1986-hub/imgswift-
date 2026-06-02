# إعداد مكتبة Transformers.js محلياً

## لماذا هذا التغيير؟
المشكلة: `Cross-Origin-Embedder-Policy: require-corp` كان يمنع تحميل المكتبة من CDN على Android Chrome.

الحل: تخزين المكتبة محلياً في مجلد `/libs/` على نفس النطاق.

## خطوة واحدة قبل النشر

```bash
bash setup-libs.sh
```

سيُنشئ مجلد `libs/` يحتوي على:
- `transformers.min.js` (~2 MB)
- `ort-wasm-simd-threaded.wasm` (~10 MB)
- `ort-wasm-simd.wasm` (~8 MB)
- `ort-wasm.wasm` (~6 MB)
- `ort-wasm-threaded.wasm` (~8 MB)

ثم ارفع كامل المشروع **بما فيه مجلد libs/** على Netlify.

## ما الذي تغيّر في الكود؟

### bg-remove.js
```js
// قبل ❌
const mod = await import('https://cdn.jsdelivr.net/npm/@xenova/transformers@2.17.2/dist/transformers.min.js');
env.backends.onnx.wasm.wasmPaths = 'https://cdn.jsdelivr.net/npm/@xenova/transformers@2.17.2/dist/';

// بعد ✅
const mod = await import('/libs/transformers.min.js');
env.backends.onnx.wasm.wasmPaths = '/libs/';
```

### netlify.toml
```toml
# قبل ❌
Cross-Origin-Embedder-Policy = "require-corp"

# بعد ✅
Cross-Origin-Embedder-Policy = "credentialless"
```

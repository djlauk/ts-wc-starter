---
to: src/index.spec.ts
inject: true
skip_if: <%= tag %>
after: "// HYGEN.IO: INJECT IMPORT HERE"
---
import './<%= tag %>.spec'
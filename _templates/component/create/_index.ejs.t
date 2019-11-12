---
to: src/index.ts
inject: true
skip_if: <%= tag %>
after: "// HYGEN.IO: INJECT EXPORT HERE"
---
export * from './<%= tag %>'
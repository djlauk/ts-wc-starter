---
to: test/visual/config.json
inject: true
skip_if: <%= tag %>
after: "\"elements\": \\["
---
    "<%= tag %>",
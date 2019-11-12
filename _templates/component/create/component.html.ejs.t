---
to: test/visual/<%= tag %>.html
---
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <title><%= tag %></title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="/dist/<%= tag %>.js" type="module"></script>
</head>

<body>
  <h2>Default</h2>
  <<%= tag %>></<%= tag %>>

  <h2>Selected</h2>
  <<%= tag %> selected></<%= tag %>>

  <h2>Name set</h2>
  <<%= tag %> name="John Doe"></<%= tag %>>
</body>

</html>

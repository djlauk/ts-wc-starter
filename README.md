# ts-wc-starter

This is a starter template project for building web components with [TypeScript][] and [lit-element][].

## Credits

I am not clever enough to have come up with this myself. The general idea, code structure and initial code were passed on to me by [Simon Green](https://github.com/CaptainCodeman/).

My work is mainly adding the more or less elaborate explanations in this README file, so I can look it up again, later.

## How to use this starter project

### Start a new project of this template

1.  Clone the project
2.  Delete the `./.git` folder, and create a new repo: `rm -rf ./git && git init`
3.  Change the following bits:
    - In `package.json`:
      - package name
      - package description
      - version
      - author
      - license (if you need)
    - In `LICENSE.md`:
      - copyright year
      - copyright holder
    - In `README.md`:
      - Put information for _your_ web component project, because _this_ README is about how to use the starter template, d'oh!
    - In `index.html`:
      - Update the `<title>`
      - Update the `<h1>`

### How to add another component

Say you'd want to implement a `<user-details>` component, here are the steps to do so.

**ATTENTION:** It's good practice to start from a known, verified "good" point. I.e. make sure all other tests pass, including the screenshot tests!

1.  Create file `src/user-details.ts`. This is where you'll implement the web component.
2.  Create file `src/user-details.spec.ts`. This is where you'll (unit) test the web component.
3.  Add `import './user-details'` to `src/index.ts`. (This is so that the build picks it up.)
4.  Add `import './user-details.spec'` to `src/index.spec.ts`. (This is so that the build picks it up.)
5.  Add `user-details` to the `elements` array in `test/config.json`. (This file governs the automation of unit and screenshot testing.)
6.  Create file `test/user-details.html` to demonstrate/test the `<user-details>` component in various states.

Finally, when you're happy with the component, generate a baseline screenshot for future reference (`npm run test:regen`).

**ATTENTION:** This will overwrite all the existing baseline screenshots, too. Make sure you didn't mess anything up, or **be extremely diligent** with what you commit to source control.

#### Hints on authoring a web component

Use these principles for guidance when writing a web component:

- The web component should behave like any other HTML tag.
- All the information the component needs to display correctly should be provided through attributes.
- Use CSS (and CSS custom varialbes) for styling.
- The component _should not_ need to make HTTP calls or other API calls. (This may not be possible when wrapping a 3rd party library into a component, though.)
- Use composition through `<slot>`s.

---

## Rationale

The following components are used to create a smooth developer experience. There are many more to choose from, but this set works together rather well and one really doesn't need much more.

### Writing web components

Writing web components is the actual goal we want to accomplish. These packages help in doing that:

- [lit-html][]: The JavaScript templating engine used by [lit-element][], optimized for efficient updates. Part of Google's [Polymer project](https://www.polymer-project.org/).
- [lit-element][]: A base class for creating web components using [lit-html][]. It's part of Google's [Polymer project](https://www.polymer-project.org/) and the successor of the [Polymer library][https://polymer-library.polymer-project.org/].
- [TypeScript][]: A static typed programming language, that is a super set of JavaScript. The static typing helps IDEs provide code suggestions and error detection.
- [tslib][]: A helper library. When the TypeScript compiler creates its output (i.e. JavaScript code), the code for certain TypeScript language features is taken from [tslib][] instead of being generated multiple times by the compiler. (This will save a few bytes per file processed.)

_Note:_ There is dispute going on over the benefits of static typing to JavaScript, but _I_ like it. JavaScript tooling has gotten much better, but I still prefer compiler errors over runtime errors.

### Testing

Common wisdom says: If you didn't test it, (assume) it's broken. (I don't remember, where I heard that the first time.)

#### Visual testing (manual)

Having a visual indication of the component is both very satisfying (as you see progress during development), and useful for testing (as you can do screenshot based tests, see below). To view web components we need to put them in an HTML page, and have that served from an HTTP server locally.

- [browser-sync][]: Provide a development web server (for local testing/execution). _Bonus:_ browser-sync will synchronize the navigation on multiple connected instances, so you just "click through" your UI in one browser, but you can view results simultaneously on multiple browsers and/or devices. Browser-sync uses [express][] as a middleware.
- [express][]: A widely used web server running on [nodejs][]. Its functionality is extended through several accompanying middleware packages:
  - [compression][]: Enable compressed transmission of content over HTTP.
  - [express-cache-headers][]: Enable cache headers in the HTTP response.
  - [express-transform-bare-module-specifiers][]: Transform bare module specifiers (like they are used inside [nodejs][] projects) to paths that browsers can consume.

#### Unit testing

Each web component should in itself be behaving according to its specifications. Unit testing checks each component individually.

- [mocha][]: A JavaScript test framework. It provides the capabilities to write test cases, i.e. it provides the `describe`, `it`, `beforeEach`, and `afterEach` functions used in the test files.
- [chai][]: A JavaScript assertion library. It provides the assertion functions (`expect` etc.) used in the test files.

#### Screenshot testing

A good way to ensure that code changes don't result in sudden changes in appearance is doing automated visual tests. After manually verifying the visual output is correct (see above), capture that as a baseline for later comparison. Then after incorporating some changes, the current visual output can be verified against that baseline automatically (by comparing the "pictures").

- [puppeteer][]: Provides an API to control Chrome (browser). This allows to programatically load the visual test page for each component in turn.
- [serve-static][]: Middleware for serving static content via HTTP. This will serve the visual test page to the automated Chrome instance.
- [pixelmatch][]: Compare to pictures, pixel by pixel.
- [pngjs][]: Encode / decode PNG images.

### The commands to run

You do not need to run these commands, but this is how all the components got into place. Maybe you'd rather run these commands instead of starting of this starter-project, after all...

```
npm init

npm install --save-dev \
 typescript \
 browser-sync \
 compression \
 express \
 express-cache-headers \
 express-transform-bare-module-specifiers

npm install --save \
 lit-html \
 lit-element \
 tslib

npm install --save-dev \
 mocha @types/mocha \
 chai @types/chai

npm install --save-dev \
 puppeteer @types/puppeteer \
 serve-static \
 pixelmatch \
 pngjs
```

[browser-sync]: https://www.browsersync.io/
[chai]: https://www.chaijs.com
[compression]: https://github.com/expressjs/compression
[express]: http://expressjs.com/
[express-cache-headers]: https://github.com/nitsujlangston/express-cache-headers
[express-transform-bare-module-specifiers]: https://github.com/nodecg/express-transform-bare-module-specifiers#readme
[lit-element]: https://lit-element.polymer-project.org/
[lit-html]: https://lit-html.polymer-project.org/
[mocha]: https://mochajs.org
[nodejs]: https://nodejs.org/en/
[pixelmatch]: https://github.com/mapbox/pixelmatch
[pngjs]: https://github.com/lukeapage/pngjs
[puppeteer]: https://github.com/GoogleChrome/puppeteer
[serve-static]: https://github.com/expressjs/serve-static
[tslib]: https://github.com/Microsoft/tslib
[typescript]: https://www.typescriptlang.org/

# jasmine-only

[![Build Status](https://travis-ci.org/davemo/jasmine-only.png?branch=master)](https://travis-ci.org/davemo/jasmine-only)

jasmine-only is a standalone plugin that you can load _after_ jasmine that adds [mocha-style](http://visionmedia.github.io/mocha/#exclusive-tests) exclusivity helpers `describe.only` and `it.only` to [jasmine 1.3.1](https://github.com/pivotal/jasmine/releases/tag/v1.3.1)

**[Download the latest version here](https://github.com/davemo/jasmine-only/releases/download/0.0.1/jasmine-only.js)**.

# examples

> The exclusivity feature allows you to run only the specified suite or test-case by appending .only() to the call

the simplest example is jasmine-only's unit test:

```coffeescript
describe "jasmine-only", ->

  describe "describe.only and it.only", ->

    normal    = jasmine.createSpy('normal spec')
    exclusive = jasmine.createSpy('exclusive spec')

    describe "normal", ->
      it "shouldnt execute this 1", normal
      it.only "it only executes this 1", exclusive

    describe.only "exclusive", ->
      it "shouldnt execute this 2", normal
      it.only "it only executes this 2", exclusive

      describe "nested exclusive", ->
        it.only "it only executes this 3", ->
          exclusive()
          expect(normal).not.toHaveBeenCalled()
          expect(exclusive).toHaveBeenCalled()
          expect(exclusive.callCount).toBe(3)

    describe.only "normal 2", ->
      it "shouldnt execute this 3", normal
```

# thanks / prior art

Much of this work is based on a [pull request](https://github.com/pivotal/jasmine/pull/309) that [@airporty](https://github.com/airportyh) issued.



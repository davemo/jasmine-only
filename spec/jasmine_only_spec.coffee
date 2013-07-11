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

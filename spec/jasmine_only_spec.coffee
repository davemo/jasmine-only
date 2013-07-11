describe "jasmine-only", ->

  it "should run only describe.only suites when at least one registered", ->
    normal    = jasmine.createSpy('normal spec')
    exclusive = jasmine.createSpy('exclusive spec')

    describe "normal", ->
      it "shouldnt execute this 1", normal
      it "shouldnt execute this 2", normal

    describe.only "exclusive", ->
      it "executes this 1", exclusive
      it "executes this 2", exclusive

      describe "nested exclusive", ->
        it "executes this 3", exclusive

    describe "normal 2", ->
      it "shouldnt execute this 3", normal

    expect(normal).not.toHaveBeenCalled()
    expect(exclusive).toHaveBeenCalled()
    expect(exclusive.callCount).toBe(3)

  it "should run only it.only suites when at least one registered", ->
    normal    = jasmine.createSpy('normal spec')
    exclusive = jasmine.createSpy('exclusive spec')

    describe "normal", ->
      it "shouldnt execute this 1", normal
      it.only "executes this 1", exclusive

    describe.only "exclusive", ->
      it "shouldnt execute this 2", normal
      it.only "executes this 2", exclusive

      describe "nested exclusive", ->
        it.only "executes this 3", exclusive

    describe.only "normal 2", ->
      it "shouldnt execute this 3", normal

    expect(normal).not.toHaveBeenCalled()
    expect(exclusive).toHaveBeenCalled()
    expect(exclusive.callCount).toBe(3)

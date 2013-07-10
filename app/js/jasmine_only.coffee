((jasmine) ->

  root = @

  originalDescribe = jasmine.Env::describe
  originalSuite    = jasmine.Suite
  originalSpec     = jasmine.Spec

  root.describe.only = (description, specDefinitions) ->
    jasmine.getEnv().describe.only(description, specDefinitions)

  root.it.only = (desc, func) ->
    jasmine.getEnv().it.only(desc, func)

  jasmine.Env::specFilter = (spec) ->
    @exclusive_ <= spec.exclusive_

  # 0 - normal
  # 1 - contains some describe.only
  # 2 - contains some it.only
  jasmine.Env::exclusive_ = 0

  describeOnly = (description, specDefinitions) ->
    suite = new jasmine.Suite(@, description, null, @currentSuite)
    suite.exclusive_ = 1
    @exclusive_ = Math.max(@exclusive_, 1)
    @describe_(suite, specDefinitions)

  jasmine.Env::describe.only = ->
    describeOnly.apply(@, arguments)

  itOnly = (description, func) ->
    _(@it(description, func)).tap (spec) =>
      spec.exclusive_ = 2
      @exclusive_ = 2

  jasmine.Env::it.only = ->
    itOnly.apply(@, arguments)

  jasmine.Env::describe = (description, specDefinitions) ->
    suite = new jasmine.Suite(@, description, null, @currentSuite)
    @describe_(suite, specDefinitions)

  jasmine.Env::describe_ = ->
    originalDescribe.apply(@, arguments)

  class jasmine.Spec extends jasmine.Spec
    constructor: (env, suite, description) ->
      @exclusive_ = suite.exclusive
      super(arguments)

  class jasmine.Suite extends jasmine.Suite
    constructor: (env, description, specDefinitions, parentSuite) ->
      @exclusive_ = parentSuite and parentSuite.exclusive_ or 0
      super(arguments)

  # jasmine.Spec = (env, suite, description) ->
  #   @exclusive_ = suite.exclusive_
  #   originalSpec.apply(@, arguments)

  # jasmine.Suite = (env, description, specDefinitions, parentSuite) ->
  #   @exclusive_ = parentSuite and parentSuite.exclusive_ or 0
  #   originalSuite.apply(@, arguments)

) jasmine

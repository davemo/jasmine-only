((jasmine) ->

  root = @

  originalRunnerSpecs = jasmine.Runner::specs

  root.describe.only = (description, specDefinitions) ->
    _(jasmine.getEnv().describe(description, specDefinitions)).tap (suite) ->
      suite.exclusive_ = true

  root.it.only = (description, specDefinition) ->
    _(jasmine.getEnv().it.only(desc, func)).tap (spec) ->
      spec.exclusive_ = true

  jasmine.Runner::specs = ->
    runner = jasmine.getEnv().currentRunner()
    suites = runner.suites_
    exclusiveSuite = _(suites).findWhere({ exclusive_: true })
    if exclusiveSuite
      runner.suites_ = [exclusiveSuite]
      originalRunnerSpecs.call(runner)
    else
      specs = originalRunnerSpecs.call(runner)
      exclusiveSpec = _(specs).findWhere({ exclusive_: true })
      if exclusiveSpec
        [exclusiveSpec]
      else
        specs

) jasmine

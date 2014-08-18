assert = require "assert"
routes = require "../src/routes"

describe "routes", ->
  describe "matching", ->
    it "should match simplest use case", ->
      route = routes.make("/")
      assert route.match "/"

    it "should match wildcards", ->
      route = routes.make("/:any")
      assert route.match "/test"
      assert route.match "/some"
      assert !(route.match "/")

    it "should match nested routes", ->
      route = routes.make("/base/:greeting")
      assert route.match "/base/sub"
      assert !(route.match "/bases/sub")

  describe "parsing", ->
    it "should parse arguments from a string", ->
      route = routes.make("/base/:wildcard/:second")
      assert.deepEqual (route.parse "/base/first/and_second"),
        wildcard: "first"
        second: "and_second"

  describe "generating", ->
    it "should generate paths with wildcards filled in", ->
      route = routes.make("/base/:first/:second")
      assert.equal route.generate("stuff", "and_more_stuff"), "/base/stuff/and_more_stuff"

    it "should generate paths from objects", ->
      route = routes.make("/base/:first/:second")

      assert.equal route.generate({second: 2, first: 1}), "/base/1/2"


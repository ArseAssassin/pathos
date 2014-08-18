assert = require "assert"
resources = require "../src/resources"

describe "resources", ->
  describe "creation", ->
    it "should create simple resources", ->
      result = resources.create
        index: "/"
        about: "/about"

      assert result.index.match "/"

    it "should create nested resources", ->
      result = resources.create
        index: "/"
        subResource: {
          _path: "/sub",
          index: "/",
          get: "/:id"
        }

      assert result.subResource.get.match "/sub/hello"

    it "should match multiple levels of nesting with wildcard routes", ->
      result = resources.create
        index: "/"
        subResource: {
          _path: "/:any",
          index: "/",
          secondary: {
            _path: "/:secondary",
            get: "/:id"
          }
        }

      assert.deepEqual result.subResource.secondary.get.parse("/parse_this/and_this/and_the_id"),
        any: "parse_this"
        secondary: "and_this"
        id: "and_the_id"



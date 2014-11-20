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

    it "should match all subresources", ->
      result = resources.create
        index: "/"
        subResource: 
          _path: "/:any"
          index: "/"
          secondary: 
            _path: "/:secondary"
            index: "/"
            get: "/:id"

      assert result.match("/any/path/here")
      assert result.match("/any/path")
      assert result.match("/any")

    it "should parse all subresources", ->
      result = resources.create
        index: "/"
        subResource: {
          _path: "/:any",
          index: "/",
          secondary: {
            _path: "/:secondary",
            index: "/"
            get: "/:id"
          }
        }

      assert.deepEqual result.parse("/any/path"),
        any: "any"
        secondary: "path"

      assert.deepEqual result.parse("/any/path/here"),
        any: "any"
        secondary: "path"
        id: "here"




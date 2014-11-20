routes = require "./routes"

module.exports = 
  create: (data, basePath="") ->
    o = 
      match: (path) ->
        for k, v of o
          if typeof v != "function" && v.match(path)
            return true
        false

      parse: (path) ->
        for k, v of o
          if typeof v != "function" && v.match(path)
            return v.parse(path)

      generate: ->
        o.index.generate.apply(o.index, arguments)

    for k, v of data
      if typeof v == "object"
        o[k] = module.exports.create(v, basePath + v._path)
      else
        if k != "_path"
          o[k] = routes.make(basePath + v)

    o

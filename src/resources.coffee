routes = require "./routes"

module.exports = 
  create: (data, basePath="") ->
    o = {}
    for k, v of data
      if typeof v == "object"
        o[k] = module.exports.create(v, basePath + v._path)
      else
        o[k] = routes.make(basePath + v)

    o

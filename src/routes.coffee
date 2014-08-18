wildcardParser = (wildcard) -> 
  match: (part) -> part != ""
  parse: (part) -> part
  isParsed: true
  name: wildcard.slice(1)

staticParser = (staticPart) -> 
  match: (part) -> staticPart == part
  isParsed: false
  content: staticPart


module.exports =
  make: (route) ->
    parts = route.split("/").map (x) ->
      if x.indexOf(":") == 0
        wildcardParser(x)
      else
        staticParser(x)

    generate: ->
      result = []

      args = Array.prototype.slice.call(arguments)

      if typeof args[0] == "object"
        getArg = (name) ->
          args[0][name]
      else
        getArg = ->
          args.shift()

      for part in parts
        if !part.isParsed
          result.push part.content
        else
          result.push getArg part.name

      result.join("/")


    match: (path) -> 
      pathParts = path.split("/")
      if pathParts.length != parts.length
        false
      else
        for n in [0..pathParts.length-1]
          parser = parts[n]
          if !parser.match(pathParts[n])
            return false

        true

    parse: (path) ->
      pathParts = path.split("/")
      result = {}
      for n in [0..pathParts.length-1]
        parser = parts[n]
        if parser.isParsed
          result[parser.name] = parser.parse(pathParts[n])

      result


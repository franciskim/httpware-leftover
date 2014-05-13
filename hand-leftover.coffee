

leftover = (options = {})->
  return (err, req, res, next)->
    if err 
      return leftover.send500(err, req, res, options)  

    return leftover.send404(req,res, options)

leftover.send500 = (err, req, res, options)-> 

  opt = options['500'] || {}
  html = """
<html>
<body style='padding:20px;'>
  <h1>#{err.toString()}</h1><em>Http Status : 500</em><pre style='margin: 15px'>#{err.stack}</pre>
</body>
</html>  

  """
  
  if opt.html?
    html = opt.html
    if (typeof(html) == "function") 
      return html err, (html)->
        res.statusCode = 500
        res.end(html)

  res.statusCode = 500
  res.end(html)
        

leftover.send404 = (req,res, options)->

  opt = options['404'] || {}
  html = "404 - Page Not Found"
  
  if opt.html?
    html = opt.html
    if (typeof(html) == "function") 
      return html (html)->
        res.statusCode = 404
        res.end(html)
        
  res.statusCode = 404
  res.end(html)


module.exports = exports = leftover  

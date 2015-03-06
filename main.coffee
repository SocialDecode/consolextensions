###

  Console Extensions for logging

###
require 'consolecolors'
timers = require './timers.js'
extraData = true

clone = (obj) ->
  return obj  if obj is null or typeof (obj) isnt "object"
  temp = new obj.constructor()
  for key of obj
    temp[key] = clone(obj[key])
  temp

consola = {
  log : clone console.log
}
console.oldLog = clone consola.log

module.exports = (info)->
  consola.log '\n'
  extraData = info.extraData if info and info.extraData

doLog = (log,color=false)->
  now = new Date()
  output = ''
  month = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic']
  if extraData
    output = now.getDate()+' '+month[now.getMonth()]+' '+
      ('0'+now.getHours()).slice(-2)+':'+
      ('0'+now.getMinutes()).slice(-2)+':'+
      ('0'+now.getSeconds()).slice(-2)+' - '
    output = output[color] if color
  xtra = ''
  if console.savedInline?
    process.stdout.clearLine()
    process.stdout.cursorTo(0)
  consola.log output+log[0],log[1]
  if console.savedInline?
    console.inline console.savedInline

console.log = (log...)->
  if Array.isArray log
    for lg in log
      doLog ['[LOG]'+':',lg],'white'
  else
    doLog ['[LOG]'+':',log],'white'
  return

console.timer = (key,quiet=false)->
  return timers.start(key,quiet)

console.info = (log)->
  if Array.isArray log
    for lg in log
      doLog ['[INFO]'.blue+':',lg],'blue'
  else
    doLog ['[INFO]'.blue+':',log],'blue'
  return

console.debug = (log, xtra...)->
  if Array.isArray log
    for lg in log
      doLog ['[DEBUG]'.magenta+':',lg],'magenta'
  else
    doLog ['[DEBUG]'.magenta+':',log],'magenta'
  return

console.warn = (log...)->
  if Array.isArray log
    for lg in log
      doLog ['[WARNING]'.yellow+':',lg],'yellow'
  else
    doLog ['[WARNING]'.yellow+':',log],'yellow'
  return

console.error = (log)->
  if typeof log is 'object'
    doLog ['[ERROR]'.red+':',log.message],'red'
    throw log
  else
    doLog ['[ERROR]'.red+':',log],'red'
  return

console.inline = (log)->
  delete console.savedInline
  console.bottomLine = {} unless console.bottomLine?
  if Array.isArray log
    console.bottomLine[log[0]] = log[1]
  if process.stdout and process.stdout.write
    process.stdout.clearLine()
    process.stdout.cursorTo(0)
    if Array.isArray log
      str = []
      str.push k+': '+v for k, v of console.bottomLine
      str = str.join(' | '.magenta)
      console.savedInline = str
    else
      console.savedInline = log
    process.stdout.write console.savedInline+'\r'
  else
    consola.log log

console.inlineEnd = ->
  consola.log console.savedInline
  if console.bottomLine
    delete console.bottomLine
    delete console.savedInline
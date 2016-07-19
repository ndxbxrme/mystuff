argv = require('minimist') process.argv.slice(2)
chalk = require 'chalk'
fs = require 'fs'
cp = require 'safe-copy-paste'
.silent()


loadStuff = ->
  stuff = {}
  if fs.existsSync '../stuff.json'
    stuff = JSON.parse fs.readFileSync('../stuff.json')
  stuff

saveStuff = (stuff) ->
  fs.writeFileSync '../stuff.json', JSON.stringify(stuff)
  return
  
set = (argv) ->
  stuff = loadStuff()
  if argv._.length is 3
    stuff[argv._[1]] = argv._[2]
  saveStuff stuff
get = (argv) ->
  stuff = loadStuff()
  cp.copy stuff[argv._[1]]
  console.log chalk.white.bold('copied to clipboard')
  return
  
  
if argv._.indexOf('set') is 0
  set argv
else if argv._.indexOf('get') is 0
  get argv
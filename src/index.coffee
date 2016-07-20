argv = require('minimist') process.argv.slice(2)
chalk = require 'chalk'
fs = require 'fs'
cp = require 'safe-copy-paste'
.silent()
appDataDir = (process.env.APPDATA or (if process.platform == 'darwin' then process.env.HOME + 'Library/Preference' else '/var/local')) + '/mystuff'
if !fs.existsSync(appDataDir)
  fs.mkdirSync appDataDir
  
loadStuff = ->
  stuff = {}
  if fs.existsSync appDataDir + '/stuff.json'
    stuff = JSON.parse fs.readFileSync(appDataDir + '/stuff.json')
  stuff

saveStuff = (stuff) ->
  fs.writeFileSync appDataDir + '/stuff.json', JSON.stringify(stuff)
  return
  
set = (argv) ->
  stuff = loadStuff()
  if argv._.length is 3
    stuff[argv._[1]] = argv._[2]
    saveStuff stuff
  if argv._.length is 2
    cp.paste (err, data) ->
      stuff[argv._[1]] = data
      saveStuff stuff
  
get = (argv) ->
  stuff = loadStuff()
  if stuff[argv._[1]]
    cp.copy stuff[argv._[1]]
    console.log chalk.white.bold('copied to clipboard')
  else
    console.log chalk.red.bold('doesn\'t exist')
  return
  
  
if argv._.indexOf('set') is 0
  set argv
else if argv._.indexOf('get') is 0
  get argv
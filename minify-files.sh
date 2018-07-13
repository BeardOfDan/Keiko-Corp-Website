!#/bin/sh
  
# Error Avoidance:
# check if the current branch's contents have been commited
#   git status --porcelain
#     If empty, then all is good, else, uncommited stuff exists
# if so, then proceed
# else, tell the user that they need to wrap things up, then exit the script
# ---
# Check if the minifier (yuicompressor) is installed
#   Probably check the version of the command, if it throws an error, then the command is not installed
# if so, then proceed
# else, tell the user that it is a dependency of the script, then exit the script

# check the current git branch
#   git rev-parse --abbrev-ref HEAD
# if minified, then proceed
# else, switch to minified, then proceed
#   copy the contents of master into minify
#   git checkout minified
#   git checkout master . #copy contents of master into minified

# minify all the js and css files
#   yuicompressor 

# perhaps try to get data from master branch log and use that for the commit message?
# Ex. At start, checkout master branch, then do git hist, save that to a var
#     Then, use that var when creating the commit message for the minified file
#     Either raw copy, or compute (Ex. 3 fixes and 2 refactors) the commit message

# git commit -am 'Commit Message Goes Here'

# echo to the user that it worked

# end of script


# ------------------
# Future Feature(s):
#   (handle first commit case)
#   Check the minified commit history, use that to check against the master branch's commit history (specifically, the commit messages).
#   Make sure that the body of the minified commit message has a listing of all of the header messages for the master branch's commit history
#   The header of the commit message for the minified branch might be a number/date combo (ex. commit #15, 01/23/18 @ 17:53). In the start of the body, before it includes the main branch's notes, should include hash for the main branch's commit that it is based on.

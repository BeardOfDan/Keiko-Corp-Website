#!/bin/bash

echo -e '\nStart of script';
echo -e   '===============\n';

# check if the git branch is clean
gitStatus=$(git status --porcelain);

if [[ "$gitStatus" != '' ]] 
then

  echo -e '\nThe branch is not clean! Please make a commit or reset the branch before running this script.\n';
  exit 1;

fi

# check if the dependencies (uglifyjs and uglifycss) are installed
# uglifyjs --version => 'uglify-es 3.3.9'
uglifyVersion=$(uglifyjs --version);
uglifyStart='uglify-es'; # the start of uglify version

if [[ $uglifyVersion != $uglifyStart* ]]
then
  
  echo -e "\nYou are missing a dependency for this script. Please run 'npm install -g uglify-es' to install the required dependency.\n";
  exit 1;

fi

currentBranch=$(git rev-parse --abbrev-ref HEAD);
currentShortHash=$(git rev-parse --short master);

if [[ $currentBranch != 'minified' ]]
then 

  git checkout minified

fi

lastCommit=$(git log -1 --pretty=%B);
lastHash=${lastCommit:29:8};

if [[ lastHash == $currentShortHash ]]
then

  echo -e '\nThe minified branch is already up to date with the master branch!\n';

  echo -e "going back to master branch...   | currentBranch: $currentBranch \n";
  git checkout $currentBranch

  exit 0;

fi

# copy master's contents into minified
git checkout master .

echo -e '\nFiles to be minified:';
echo      '---------------------';

find public/js -type f \
  -name "*.js" ! -name "*.min.*" ! -name "vfs_fonts*" \
  -exec echo {} \; \
  -exec uglifyjs -o {}.min {} \; \
  -exec rm {} \; \
  -exec mv {}.min {} \;

git commit -am "branch: $currentBranch | short hash: $currentShortHash"

# push updated minify branch
#echo -e '\ngit push productionServerRemote minifiedBranch';
echo 'TODO: add line to push to server'

git checkout $currentBranch

echo -e '\n=============';
echo -e   'End of script\n';

# ================
# Below is outline
# ================

# Error Avoidance:
# check if the current branch's contents have been commited
#   git status --porcelain
#     If empty, then all is good, else, uncommited stuff exists
#     Note: when editing this script, it will show up as an untracked change
# if so, then proceed
# else, tell the user that they need to wrap things up, then exit the script
# ---
# Check if the minifier (yuicompressor) is installed
#   Probably check the version of the command, if it throws an error, then the command is not installed
# if so, then proceed
# else, tell the user that it is a dependency of the script, then exit the script

# check the current git branch
#   git rev-parse --abbrev-ref HEAD # name of current branch
# if minified, then proceed
# else, switch to minified, then proceed
#   git checkout minified
#   git checkout master . #copy contents of master into minified
#   -----
#   alternatively, git merge -> https://git-scm.com/docs/git-merge

# minify all the js and css files
#  yuicompressor 
#    appears to be deprecated
#  uglifyjs + uglify css
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

# git rev-parse HEAD # gets hash of current commit
# git rev-parse --short HEAD # gets SHORT hash of current commit


# Use the hash of the last used master branch commit to figure out which files need to be minified (because they were chanaged) and only minify them, otherwise, reuse the existing minified files

# Allow for an argument to be passed to tell the script to push to the server before exiting







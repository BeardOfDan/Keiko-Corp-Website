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

uglifyCssVersion=$(uglifycss --version);
uglifyCssStart='uglifycss'; # the start of uglifycss version

if [[ $uglifyCssVersion != $uglifyCssStart* ]]
then

  echo -e "You are missing a dependency for this script. Please run 'npm install -g uglifycss' to install the required dependency.\n";
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

  echo -e "going back to the previous branch...\n";
  git checkout $currentBranch

  exit 0;

fi

# copy master's contents into minified
git checkout master .

echo -e '\nJS files to be minified:';
echo      '------------------------';

find public/js -type f \
  -name "*.js" ! -name "*.min.*"  \
  -exec echo {} \; \
  -exec uglifyjs -o {}.min {} \; \
  -exec rm {} \; \
  -exec mv {}.min {} \;

echo ''; # blank line for formatting

echo -e '\nCSS files to be minified:';
echo      '-------------------------';

find public/css -type f \
  -name "*.css" ! -name "*.min.*" \
  -exec echo {} \; \
  -exec uglifycss --output {}.min {} \; \
  -exec rm {} \; \
  -exec mv {}.min {} \;

echo ''; # blank line for formatting

echo -e 'Minifying public/index.html ...\n';

html-minifier --remove-comments --collapse-whitespace --minify-js true --minify-css true public/index.html -o public/index.html

echo ''; # blank line for formatting

git commit -am "branch: $currentBranch | short hash: $currentShortHash"

echo ''; # blank line for formatting

# push updated minify branch
# command line arguments are used to determine if the script will push the new commit
# $1 is the remote name
# $2 is the branch name
if [ $1 ]
  then

  if [ $2 ]
    then

    git push $1 $2;

  else

    git push $1 master;

  fi
else

  echo -e '\nIf you want the script to push, then add 1 argument for the remote name and a second argument for the branch name';

fi

echo ''; # blank line for formatting

git checkout $currentBranch

echo -e '\n=============';
echo -e   'End of script\n';

# ================
# Below is outline
# ================

# Future Feature(s):
#   (handle first commit case)
#   Check the minified commit history, use that to check against the master branch's commit history (specifically, the commit messages).

# git rev-parse HEAD # gets hash of current commit
# git rev-parse --short HEAD # gets SHORT hash of current commit


# Use the hash of the last used master branch commit to figure out which files need to be minified (because they were chanaged) and only minify them, otherwise, reuse the existing minified files








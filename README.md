
# Performance Keiko Corp Website

This project is an exercise in taking a foreign code base and improving the performance. At current, the Google PageSpeed Insights are above 90 for both mobile and desktop. At the start, they were seriously lower (TODO: push an old commit to the server and run a test to get the scores for the initial version).

---

## Notes on contributing

To fully optimise performance, code will be pushed from a 'minified' branch, which uses all the same code as the 'master' branch, but with all of the files minified. Any changes made should affect the master branch, then update the 'minified' branch.

This can be done automatically by running the minified script: 'npm run minified'

Note: The minification script is in bash, and will therefore require the bash shell to run in
Note: you may need to use the chmod command to enable use of the script


# Performance Keiko Corp Website

This project is an exercise in taking a foreign code base and improving the performance. At current, the Google PageSpeed Insights are above 90 for both mobile and desktop. At the start, they were seriously lower (TODO: push an old commit to the server and run a test to get the scores for the initial version).

---

## Current Speed Test Scores

#### Google Page Speed Insights Optimization:
  *  Mobile: 99/100
  *  Desktop: 94/100

#### Web Page Performance Test:
  * First Byte Time: A
  * Keep-alive Enabled: A
  * Compress Transfer: A
  * Compress Images: A

#### Pingdom Website Speed Test:
  * Performance grade: 82/100
  * Page size: 720.0 KB
  * Load time: 192 ms
  * Requests: 46

#### GTmetrix:
  * PageSpeed Score: 91%
  * YSlow Score: 75%
  * Fully Loaded Time: 1.4 s
  * Total Page Size: 736 KB
  * Requests: 46

---

## Notes on contributing

To fully optimise performance, code will be pushed from a 'minified' branch, which uses all the same code as the 'master' branch, but with all of the files minified. Any changes made should affect the master branch, then update the 'minified' branch.

This can be done automatically by running the minified script: 'npm run minified'

Note: The minification script is in bash, and will therefore require the bash shell to run in
Note: you may need to use the chmod command to enable use of the script

---

## Known Bugs

Due to a dependency in html-minifier, inline JavaScript is not currently minified in public/index.html. This is likely a simple fix, but has not been implemented yet, as it affects the minification of JavaScript files (they use a different minifier, and I need to ensure that installing the html dependency does not pollute the namespace).

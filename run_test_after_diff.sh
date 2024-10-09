#!/bin/bash

# Get the list of changed, added, or untracked test files in the current uncommitted state
changed_tests=$(git diff --name-only --diff-filter=AM | grep 'src/test/java/.*Test\.java')
untracked_tests=$(git ls-files --others --exclude-standard | grep 'src/test/java/.*Test\.java')

# Combine the lists and format for Maven
all_tests=$(echo -e "$changed_tests\n$untracked_tests" | sed 's/src\/test\/java\///;s/\//./g;s/\.java//' | paste -sd, -)

# Check if there are any test files to run
if [ -n "$all_tests" ]; then
  # Run the tests
 mvn test -Dtest="$all_tests"
else
  echo "No test files have been changed, added, or are untracked."
fi

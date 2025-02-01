#!/bin/zsh

rm -f lyra/webapp/store.json

for dir in ./test-*/; do
  if [ -d "$dir" ]; then

    git_branch=$(git rev-parse --abbrev-ref HEAD)
    git diff --quiet "$dir"
    git_dirty=$?

    if [[ "$git_branch" == "main" && "$git_dirty" -eq 0 ]]; then
      is_clean=true
    else
      is_clean=false
    fi

    if $is_clean; then
      echo "✅ $dir"
    else
      echo "❌ $dir"
      cd "$dir"
      git clean -fd
      git checkout -- .
      git reset
      git checkout main
      git reset --hard origin/main
    fi
  fi
done

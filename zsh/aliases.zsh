alias gti='git'

alias rnf="echo 'Running specs excluding all features'; bundle exec rspec --exclude-pattern 'spec/{stripe_features,features}/**/*_spec.rb'"

alias gnb='git co -b'
alias gbmv='git branch -m $(git symbolic-ref --short HEAD)'
alias gaa='git add .'
alias gc='git commit'
alias gca='git commit -a'
alias gcam='git commit -am'
alias gcamend='git commit --amend'
alias gcamenda='git commit --amend --all'
# The command shuld exclude db/schema.rb
alias rubocopchanges='git diff --name-only main | grep .rb | grep -v db/schema.rb | xargs rubocop'

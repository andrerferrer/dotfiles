ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins for Le Wagon bootcamps
# plugins=(git gitfast last-working-dir common-aliases sublime zsh-syntax-highlighting history-substring-search)
# plugins=(gitfast last-working-dir common-aliases sublime zsh-syntax-highlighting history-substring-search ssh-agent)
plugins=(git gitfast last-working-dir common-aliases sublime zsh-syntax-highlighting history-substring-search pyenv)

# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

ZSH_DISABLE_COMPFIX=true
# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load rbenv if installed (to manage your Ruby versions)
export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# Load pyenv (to manage your Python versions)
export PATH="${HOME}/.pyenv/bin:${PATH}" # Needed for Linux/WSL
export PYENV_VIRTUALENV_DISABLE_PROMPT=1 # https://github.com/pyenv/pyenv-virtualenv/issues/135
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[🐍 $(pyenv_prompt_info)]'

# Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Call `nvm use` automatically in a directory with a `.nvmrc` file
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use --silent
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    nvm use default --silent
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Load 'lewagon' virtualenv for the Data Bootcamp. You can comment these 2 lines to disable this behavior.
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# pyenv activate lewagon 2>/dev/null && echo "🐍 Loading 'lewagon' virtualenv"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# WINDOWS ONLY!
# Encoding stuff for the terminal
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
# export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"
# export DISPLAY=:0
# export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"
# export DISPLAY=:0
# export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe
# sudo /etc/init.d/postgresql start
# alias chrome="/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe"

# Start posgresql
sudo /etc/init.d/postgresql start

# Andre's aliases

## Text editors
alias stt='subl .'
alias st='subl'
alias vsc='code .'

## Git && Github
alias g='git'
alias gd='git diff'
alias gr='git reset'
alias grhh='git reset HEAD~ --hard'
alias grh1='git reset HEAD~1'
alias grv='git remote -v'
alias grro='git remote remove origin'
alias gst='git status'
alias go='git checkout'
alias go.='git checkout .'
alias gob='git checkout -b'
alias gom='git checkout master'
alias gomm='git checkout master && git pull origin master && bundle && yarn'
alias gf='git fetch'
alias gl='git pull'
alias glo='git pull origin'
alias glom='git pull origin master'
alias glum='git pull upstream master'
alias gmm='git merge master'
alias ga='git add'
alias gacm='git add . && git commit -m'
alias gsa='git submodule add'
alias ga.='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gphm='git push heroku master'
alias gpsm='git push staging HEAD:master'
alias gpo='git push origin'
alias gpom='git push origin master'
alias gpsup='git push --set-upstream origin master'
alias hc='hub create'

## Heroku
alias h='heroku'
alias hr='heroku run'
alias hrr='heroku run rails'

## Packages
alias b='bundle'
alias be='bundle exec'
alias ber='bundle exec rspec'
alias bes='bundle exec sidekiq -C config/sidekiq.yml'
alias byr='bundle install && yarn install && rails db:drop db:create db:migrate db:seed'
alias byrs='bundle install && yarn install && rails db:drop db:create db:migrate db:seed && rails s'
alias y='yarn'
alias wds='webpack-dev-server'


## Rails aliases
alias r='rails'
alias rg='rails generate'
alias rdbm='rails db:migrate'
alias rdbmr='rails db:migrate:reset'
alias seed='rails db:seed'
alias seedr='rails db:seed:replant'
alias db-reset='rails db:drop db:create db:migrate db:seed'

## ETC

### Rubocop
alias rc='rubocop'
alias rca='rubocop -a'
### Open chrome
alias chrome='$BROWSER'
alias c='chrome'
### say yes
alias Y='yes |'
### Copy easier
alias cpr='cp -r'
alias cpry='Y cp -r'
### open with windows explorer
alias wopen='explorer.exe .'
### open with ubuntu explorer
alias xopen='xdg-open'
alias xopen.='xdg-open .'
### Update Ubuntu
alias update="sudo apt-get update -y && sudo apt-get upgrade -y"


# HACKS
alias find_node_modules="find . -name "node_modules" -type d -prune -print | xargs du -chs"
alias clean_node_modules="find . -name "node_modules" -exec rm -rf '{}' +"

# local variables
react='/home/andrerferrer/code/andrerferrer/studying/react-studies'
cdb='/home/andrerferrer/code/andrerferrer/codgo/cashback-do-bem'
challenges='home/code/andrerferrer/lewagon/challenges'
lw='/home/andrerferrer/code/andrerferrer/lewagon/'

export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"

alias db-reset='rails db:drop db:create db:migrate db:seed'
export DISPLAY=172.24.80.1:0
export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"

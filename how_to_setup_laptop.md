### Essentials for running projects

* VirtualBox, for my old computer, to enable docker: https://www.virtualbox.org/wiki/Downloads
* Docker: https://hub.docker.com/editions/community/docker-ce-desktop-mac
  * Add Kitematic download
* Java: https://www.java.com/en/download/mac_download.jsp
	* edit `~/.profile`: `export JAVA_HOME="/usr/libexec/java_home -v 1.8"`
* Anaconda, for Python environments: https://www.anaconda.com/download/#macos
* Rstudio, for R environments: https://www.rstudio.com/products/rstudio/download/#download
  * R: https://cran.rstudio.com
    * R developer tools: https://cran.rstudio.com/bin/macosx/tools/
      * edit `~/.profile`: `export PATH=/usr/local/clang6/bin:$PATH`
  * TeX distribution: https://www.tug.org/mactex/mactex-download.html

* DBeaver is a nice, free, database UI: https://dbeaver.io
  *  needs Java Platform JDK


### Basic requirements for Anaconda Python

* add virtual environment commands to `~/.profile`: 
	
```
if [ -f "${HOME}/miniconda3/etc/profile.d/conda.sh" ]; then
    . "${HOME}/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="${HOME}/miniconda3/bin:$PATH"
fi
```


### Basic requirements for R

```
install.packages("tidyverse")
install.packages("data.table")
install.packages("caret")
install.packages("xgboost")
install.packages("MatchIt")
```


### brew

```
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

#### homebrew stuff


consider installing cmake, git, libpq, python3

### git

```
brew install git
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
```

* add to `~/.profile`:

```
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
```

* create `~/.gitconfig` for any global git settings


### psql

```
brew install libpq
```

* Gives some handy output:

```
libpq is keg-only, which means it was not symlinked into /usr/local,
because conflicts with postgres formula.

If you need to have libpq first in your PATH run:
  echo 'export PATH="/usr/local/opt/libpq/bin:$PATH"' >> ~/.bash_profile

For compilers to find libpq you may need to set:
  export LDFLAGS="-L/usr/local/opt/libpq/lib"
  export CPPFLAGS="-I/usr/local/opt/libpq/include"

For pkg-config to find libpq you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/libpq/lib/pkgconfig"
```

* Symlink `psql` and `pg_dump` from the un-symlinked libpq to the `$PATH` in `~/.profile`:

```
ln -s /usr/local/opt/libpq/bin/psql /usr/local/bin/psql
ln -s /usr/local/opt/libpq/bin/pg_dump /usr/local/bin/pg_dump
```

* Create `.pgpass` with correct permissions

```
touch ~/.pgpass
chmod 0600 ~/.pgpass
```

* setup `.psqlrc`:

```
\set QUIET 1

-- Errors are ignored in interactive sessions,
-- and not when reading script files.
\set ON_ERROR_ROLLBACK interactive

-- To have all queries display query times.
\timing

-- Verbose error reports.
\set VERBOSITY verbose

-- Use table format (with headers across the top) by default,
-- but switch to expanded table format when there's a lot of data,
-- which makes it much easier to read.
\x auto

-- Use a separate history file per-database.
\set HISTFILE ~/.psql_history- :DBNAME

-- If a command is run more than once in a row,
-- only store it once in the history.
\set HISTCONTROL ignoredups

-- By default, NULL displays as an empty space. Is it actually an empty
-- string, or is it null? This makes that distinction visible.
\pset null '(null)'

-- autocomplete keywords to upper case
\set COMP_KEYWORD_CASE upper

-- custom prompt to show host and database
\set PROMPT1 '%M:%> %n@%/%R%#%x '

\unset QUIET
```


### sublime-text

* Symlink the useful command:

```
## command line sublime text
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
```

* edit user settings with this

```
{
    "theme": "Default.sublime-theme",
    "translate_tabs_to_spaces": true,
    "highlight_line": true,
    "shift_tab_unindent": true,
    "rulers": [80],
    "draw_white_space": "all",
    "wrap_width": 80
}
```


### tmux

```
brew install tmux
```

* Gives some handy output:

```
==> openssl
A CA file has been bootstrapped using certificates from the SystemRoots
keychain. To add additional certificates (e.g. the certificates added in
the System keychain), place .pem files in
  /usr/local/etc/openssl/certs

and run
  /usr/local/opt/openssl/bin/c_rehash

openssl is keg-only, which means it was not symlinked into /usr/local,
because Apple has deprecated use of OpenSSL in favor of its own TLS and crypto libraries.

If you need to have openssl first in your PATH run:
  echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.bash_profile

For compilers to find openssl you may need to set:
  export LDFLAGS="-L/usr/local/opt/openssl/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl/include"

For pkg-config to find openssl you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"
```

* setup `.tmux.conf`:

```
# 0 is too far from ` ;)
set -g base-index 1
setw -g pane-base-index 1

# No delay for escape key press
set -sg escape-time 0

# Shift arrow to switch panes
bind -n S-Left  select-pane -L
bind -n S-Right select-pane -R

# Reload tmux config
bind r source-file ~/.tmux.conf
```


## vim

* setup `.vimrc`:

```
"" General
set number  " Show line numbers
set linebreak   " Break lines at word (requires Wrap lines)
set showbreak=+++   " Wrap-broken line prefix
set textwidth=80    " Line wrap (number of cols)
set showmatch   " Highlight matching brace
set errorbells  " Beep or flash screen on errors
set visualbell  " Use visual bell (no beeping)
 
set hlsearch    " Highlight all search results
set smartcase   " Enable smart-case search
set ignorecase  " Always case-insensitive
set incsearch   " Searches for strings incrementally
 
set autoindent  " Auto-indent new lines
set expandtab   " Use spaces instead of tabs
set shiftwidth=4    " Number of auto-indent spaces
set smartindent " Enable smart-indent
set smarttab    " Enable smart-tabs
set softtabstop=4   " Number of spaces per Tab
 
"" Advanced
set ruler   " Show row and column ruler information
set showtabline=2   " Show tab bar
 
set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour
 
 
"" Generated by VimConfig.com

"set backspace=2         " backspace in insert mode works like normal editor
syntax on               " syntax highlighting
filetype indent on      " activates indenting for files
set autoindent          " auto indenting
set number              " line numbers
colorscheme desert      " colorscheme desert
set nobackup            " get rid of anoying ~
set textwidth=80        " wrap at 80 characters
```
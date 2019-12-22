
### docker

* download installer and run it
* install kitematic

### java

* install java JDK
https://www.oracle.com/technetwork/java/javase/downloads/jdk13-downloads-5672538.html

### mactex

* install TeX distribution:
https://www.tug.org/mactex/mactex-download.html

### brew

* install package manager

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

* install packages

```
brew cask install sublime-text
brew cask install dbeaver-community
brew install git
brew install libpq
brew install make
brew install python
brew install sqlite3
brew install tmux
```

### dotfiles

* clone the dotfiles repo

```
cd $DOTHOME
bash setup_dotfiles.sh
```

* check lines are in to `~/.zshrc`

```
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
```

### git

* setup `~/.gitconfig` with appropriate username and email
* set up git command completion

```
cd
mkdir .zsh
cd .zsh
curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
```

* add lines to `~/.zshrc`

```
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)
```

* then

```
rm ~/.zcompdump
source ~/.zshrc
```

* use the instructions [here](https://mattorama.github.io/vernix/git/2016/06/23/two-github-accounts.html) to configure SSH for both accounts
* for multiple github accounts, set up a ssh config with content like this

```
Host github.com
  HostName github.com
  User git
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa

Host mattorama.github.com
  HostName github.com
  User git
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa_mattorama
```

### python

```
pip3 install ipython
pip3 install ipdb
pip3 install pylint
pip3 install pytest
```

### anaconda python

* download installer and run it
* add lines to `~/.profile`

```
if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
else
    export PATH="$HOME/anaconda3/bin:$PATH"
fi
```

* add channels to `~/.condarc`

```
conda config --append channels conda-forge
conda config --append channels anaconda
```

* add essentials to base environment

```
conda activate
conda install pytest
```

* add some extras so that plotly works in jupyterlab

```
conda activate
conda install nodejs
conda install -c plotly plotly
```

* set up plotly with jupyter lab

```
export NODE_OPTIONS=--max-old-space-size=4096
jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build
jupyter labextension install jupyterlab-plotly --no-build
jupyter labextension install plotlywidget --no-build
jupyter lab build
unset NODE_OPTIONS
```

* install static export for plotly

```
conda install -c plotly plotly-orca
```

### rstudio

* install R
  * install devtools
    * add to path for compiler

```
export PATH="/usr/local/clang6/bin:$PATH"
```

* install RStudio
* within R, add packages

```
install.packages("knitr")
install.packages("tidyverse")
install.packages("data.table")
install.packages("xgboost")
install.packages("MatchIt")
install.packages("forecast")
install.packages("plotly")
```

### sublime-text

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

* install package control from tools menu
* install packages using the command pallette

```
anaconda
gitgutter
markdownpreview
magicpython
origami
SideBarEnhancements
sublimelinter
sublimelinter-pylint
sublimelinter-pyyaml
```

* configure SublimeLinter to use Anaconda3 Python for finding paths

```
{
    "linters": {
        "pylint": {
            "python": "~/anaconda3/bin/python"
        }
    }
}
```
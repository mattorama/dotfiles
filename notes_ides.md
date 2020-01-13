# conclusions

* sublime text for most writing, especially when project is large
* jupyter lab for generating notebooks of plots and interactive documentation
* vscode for more involved interactive debugging

# requirements for text editor / IDE

* autocomplete
* linting
* run code
* interactive debugger
* run tests

## sublime/terminal/jupyter

command line launch
virtual environment
linter
autocomplete
function documentation popup for jupyter lab consolse
run file in terminal
run file in interactive terminal
interactive debugger using import ipdb
run tests using pytest
jupyter notebook separately

## vs code

command line launch
virtual environment
linter
autocomplete
function documentation popup
function documentation popup for imported packages
run file in terminal
run file in interactive terminal
interactive debugger
jupyter notebook integrated

## pycharm

command line launch
virtual environment
linter
run file in terminal
run file in interactive terminal
jupyter notebook in pro edition only

## overall

For autocomplete and linting, Sublime was best. For virtual environments, VSCode was best. Consider that all code running activities---run, debug, test---can be done in Terminal anyway. Debugging is better in VSCode because of breakpoint setting and remote interpreter accessibility. I preferred Sublime for navigating large bodies of text. I preferred VSCode for running the code. Terminal does most stuff here, but VSCode has the edge for debugging and interpreter management.

For plotting, VSCode can do it, but it's somewhat clumsy. VSCode appears to be lighter weight compared to JupyerLab. I will need to evaluate both with Plotly and Dash in separate environments.

How do I get all of this on a Docker container? The coding part is OK, it's the headache with Jupyter that is not OK.

I need to get faster at writing tests, running and debugging code in context.

## pycharm: 5/5

The debugger has more going on than VSCode, but it appears to be trickier to set up. Once I have a project with a virtual environment or a docker container I will try to set up the interpreter and debugger with it.

## vscode: 5/5

```
alias code="${HOME}/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
```

* autocomplete works with the python extension and interpreter selected
* works with virtual environments using select interpreter
* has interactive debugger
* can preview jupyter notebooks
* linter works when installed with conda into conda environment
* linter works when installed with pip into pip environment
* run tests from integrated terminal

### installed extensions

* anaconda extension pack
* autodocstring
* docker
* git history
* git project manager
* gitlens
* markdown all in one
* markdownlint
* postgresql
* python
* terminal
* yaml


## sublime: 4/5

* autocomplete: use the MagicPython package
* install a python linter to work with the linting package:

```
conda install -c anaconda pylint
pylint /path/to/module
```

* run code: use the Anaconda package
* create a build by creating a custom `.sublime-build` file:

```
{
    "cmd": ["/Users/matt/miniconda3/bin/python", "-u", "$file"],
    "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)",
    "selector": "source.python"
}
```

* run interactive debugger from Terminal with folling lines in code
* run interactive debugger from SublimeREPL (see JSON below)

* run tests from Terminal

### installed extensions

package control
anaconda (IDE)

```
{"python_interpreter": "/usr/local/bin/python3"}
```

gitgutter
markdownpreview
magicpython (highlighter) https://github.com/MagicStack/MagicPython
origami
SideBarEnhancements
sublimelinter http://www.sublimelinter.com
sublimelinter-pylint https://github.com/SublimeLinter/SublimeLinter-pylint
sublimelinter-pyyaml
sublimerepl (repl)

### Best shortcuts

* make sure Sublime CLI is symlinked

```
$ sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/bin/subl
```

* Goto Anything Cmd+P is used for quickly finding and opening files. Just type in a part of a path and filename within a project and you can easily open that file. This is great for quickly opening files in large Django projects.
* Goto Line Number Ctrl+G takes you to a specific line number in an active file.
* Goto Symbol Cmd+R lists all functions and classes within a file to make them easier to find. Simply start typing the one you want.
* Go to beginning of line Cmd+Left and Go to end of line Cmd+Right help you navigate within lines.
* Delete current line Ctrl+Shift+K deletes the current line.
* Multi-Edit is by far my favorite shortcut:
    * Select a word and press Cmd+D to select the next same word. Then press Cmd+D again to select the next same word again, and so on.
    * Press Cmd+Left Button to create a cursor for editing everywhere you click.
* Block select Option+Left Button is used to select a block of text. It’s perfect for removing blank space when formatting a CSV file.
* Block-Edit select txt then Cmd+Shift+L

### Custom SublimeREPL menu items

* Main.sublime-menu

```
[
     {
        "id": "tools",
        "children":
        [{
            "caption": "SublimeREPLPython3",
            "mnemonic": "r",
            "id": "SublimeREPLPython3",
            "children":
            [
                {"caption": "Python 3 - Brew",
                "id": "Python3",

                 "children":[
                    {"command": "repl_open",
                     "caption": "Python 3",
                     "id": "repl_python3",
                     "mnemonic": "p",
                     "args": {
                        "type": "subprocess",
                        "encoding": "utf8",
                        "cmd": ["/usr/local/bin/python3", "-i", "-u"],
                        "cwd": "$file_path",
                        "syntax": "Packages/Python/Python.tmLanguage",
                        "external_id": "python",
                        "extend_env": {"PYTHONIOENCODING": "utf-8"}
                        }
                    },
                    {"command": "repl_open",
                     "caption": "Python3 - PDB current file",
                     "id": "repl_python_pdb",
                     "mnemonic": "D",
                     "args": {
                        "type": "subprocess",
                        "encoding": "utf8",
                        "cmd": ["/usr/local/bin/python3", "-i", "-u", "-m", "pdb", "$file_basename"],
                        "cwd": "$file_path",
                        "syntax": "Packages/Python/Python.tmLanguage",
                        "external_id": "python",
                        "extend_env": {"PYTHONIOENCODING": "utf-8"}
                        }
                    },
                    {"command": "repl_open",
                     "caption": "Python3 - RUN current file",
                     "id": "repl_python_run",
                     "mnemonic": "R",
                     "args": {
                        "type": "subprocess",
                        "encoding": "utf8",
                        "cmd": ["/usr/local/bin/python3", "-u", "$file_basename"],
                        "cwd": "$file_path",
                        "syntax": "Packages/Python/Python.tmLanguage",
                        "external_id": "python",
                        "extend_env": {"PYTHONIOENCODING": "utf-8"}
                        }
                    },
                    {"command": "repl_open",
                     "caption": "Python 3 - IPython",
                     "id": "repl_python_ipython3",
                     "mnemonic": "p",
                     "args": {
                        "type": "subprocess",
                        "encoding": "utf8",
                        "autocomplete_server": true,
                        "cmd": {
                            "osx": ["/usr/local/bin/ipython3"]
                        },
                        "cwd": "$file_path",
                        "syntax": "Packages/Python/Python.tmLanguage",
                        "external_id": "python",
                        "extend_env": {
                            "PYTHONIOENCODING": "utf-8",
                            "SUBLIMEREPL_EDITOR": "$editor"
                        }
                    }
                    }
                ]},

                {"caption": "Python 3 - Conda",
                "id": "Python",

                 "children":[
                    {"command": "repl_open",
                     "caption": "Python3",
                     "id": "repl_python",
                     "mnemonic": "P",
                     "args": {
                        "type": "subprocess",
                        "encoding": "utf8",
                        "cmd": ["/Users/matt/miniconda3/bin/python", "-i", "-u"],
                        "cwd": "$file_path",
                        "syntax": "Packages/Python/Python.tmLanguage",
                        "external_id": "python",
                        "extend_env": {"PYTHONIOENCODING": "utf-8"}
                        }
                    },
                    {"command": "repl_open",
                     "caption": "Python3 - PDB current file",
                     "id": "repl_python_pdb",
                     "mnemonic": "D",
                     "args": {
                        "type": "subprocess",
                        "encoding": "utf8",
                        "cmd": ["/Users/matt/miniconda3/bin/python", "-i", "-u", "-m", "pdb", "$file_basename"],
                        "cwd": "$file_path",
                        "syntax": "Packages/Python/Python.tmLanguage",
                        "external_id": "python",
                        "extend_env": {"PYTHONIOENCODING": "utf-8"}
                        }
                    },
                    {"command": "repl_open",
                     "caption": "Python3 - RUN current file",
                     "id": "repl_python_run",
                     "mnemonic": "R",
                     "args": {
                        "type": "subprocess",
                        "encoding": "utf8",
                        "cmd": ["/Users/matt/miniconda3/bin/python", "-u", "$file_basename"],
                        "cwd": "$file_path",
                        "syntax": "Packages/Python/Python.tmLanguage",
                        "external_id": "python",
                        "extend_env": {"PYTHONIOENCODING": "utf-8"}
                        }
                    },
                    {"command": "repl_open",
                     "caption": "Python3 - IPython3",
                     "id": "repl_python_ipython",
                     "mnemonic": "I",
                     "args": {
                        "type": "subprocess",
                        "encoding": "utf8",
                        "autocomplete_server": true,
                        "cmd": {
                            "osx": ["/Users/matt/miniconda3/bin/ipython"]
                        },
                        "cwd": "$file_path",
                        "syntax": "Packages/Python/Python.tmLanguage",
                        "external_id": "python",
                        "extend_env": {
                            "PYTHONIOENCODING": "utf-8",
                            "SUBLIMEREPL_EDITOR": "$editor"
                        }
                    }
                    }
                ]}
            ]
        }]
    }
]
```

* Python3.sublime-menu

```
[
    {
        "caption": "REPL: Python 3",
        "command": "run_existing_window_command", "args":
        {
            "id": "repl_python3",
            "file": "config/Python/Main.sublime-menu"
        }
    },
    {
        "caption": "REPL: Python 3 - PDB current file",
        "command": "run_existing_window_command", "args":
        {
            "id": "repl_python3_pdb",
            "file": "config/Python/Main.sublime-menu"
        }
    },
    {
        "caption": "REPL: Python 3 - RUN current file",
        "command": "run_existing_window_command", "args":
        {
            "id": "repl_python3_run",
            "file": "config/Python/Main.sublime-menu"
        }
    },
    {
        "caption": "REPL: Python 3 - IPython",
        "command": "run_existing_window_command", "args":
        {
            "id": "repl_python3_ipython",
            "file": "config/Python/Main.sublime-menu"
        }
    },
    {
        "caption": "REPL: Python 3 - Conda ",
        "command": "run_existing_window_command", "args":
        {
            "id": "repl_python3_conda",
            "file": "config/Python/Main.sublime-menu"
        }
    },
    {
        "caption": "REPL: Python 3 - Conda - PDB current file",
        "command": "run_existing_window_command", "args":
        {
            "id": "repl_python3_conda_pdb",
            "file": "config/Python/Main.sublime-menu"
        }
    },
    {
        "caption": "REPL: Python 3 - Conda - RUN current file",
        "command": "run_existing_window_command", "args":
        {
            "id": "repl_python3_conda_run",
            "file": "config/Python/Main.sublime-menu"
        }
    },
    {
        "caption": "REPL: Python 3 - Conda - IPython",
        "command": "run_existing_window_command", "args":
        {
            "id": "repl_python3_conda_ipython",
            "file": "config/Python/Main.sublime-menu"
        }
    }
]
```
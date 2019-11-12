## brew python environment

* this is useful for having a single python version on your local machine

* install python
```
brew install python
```

* pip gets installed automatically as `pip3`

```
/usr/local/bin/python3
/usr/local/bin/ipython3
```

* install some "standard" python modules for programming

```
pip install ipdb
pip install ipython
pip install pylint
pip install pytest
```

* create virtual environments with `venv` and manage with `pip`
* if multiple python versions are required, move to `conda`

```
python3 -m pip install --user --upgrade pip
cd /path/to/project
python3 -m venv env
source env/bin/activate
deactivate
```

* add a package to your project
```
pip install sklearn pandas
```

* freeze the requirements
```
pip freeze > requirements.txt
```

* create an environment from a requirements file

```
pip install -r requirements.txt
```

* deactivate the virtual environment
```
deactivate
```

* use this install to create python only environments for programming projects

## conda python environment

* this is useful when you need multiple python versions and/or non-python libraries

```
~/miniconda3/bin/python
~/miniconda3/bin/ipython
```

* install the basics into base

```
conda activate base
conda install ipython, ipdb, pylint, pytest
```

* use the `base` environment for basic programming
* create other environments for more data science and machine learning tasks

```
conda env create -f environment.yml
conda activate <env_name>
conda deactivate
```

* if application is sensitive to OS, move to `docker` environment
* I found problems relating to old OS when `numpy` went from `1.16` to `1.17` that occurred in `conda` but not in `venv`.
* packages in a conda environment installed using conda pip are not accessible when using IPython
* add PYTHONPATH when running IPython in conda environment
`PYTHONPATH=. ipython`

## linting

```
pylint /path/to/module
```

## running tests

* put the tests in a separate directory
* include the `PYTHONPATH`

```
pip3 install pytest
```

```
conda install -c anaconda pytest
```

```
(base) trapezion[master ?]$ PYTHONPATH='py' pytest py/tests/
(base) py[master ?]$ PYTHONPATH='.' pytest tests/
```

## interactive debugging


```
import ipdb
ipdb.set_trace()
```

```
from IPython.core.debugger import set_trace
set_trace()
```

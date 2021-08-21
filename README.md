# Handles github repositories

- repo-list-github
- repo-modified.sh
- repo-pull-clone.sh

## Usage

_Do the following steps_

- `cd && mkdir git-github && cd git-github` : git-github will contain the whole repositories
- `git clone https://github.com/doali/github.git` : fetch one project to fetch the others
- `cd github`
- `./repo-pull-clone.sh` : fetch the whole projects excepted github
- `ls ..` : let us check

## Settings

- from `${HOME}/.local/bin/repo-modified` create

```bash
#!/usr/bin/env bash

cd ${HOME}/git-github/github 1> /dev/null
./repo-modified.sh 
cd - 1> /dev/null
```

- from `${HOME}/.local/bin/repo-pull-clone` create

```bash
#!/usr/bin/env bash

cd ${HOME}/git-github/github 1> /dev/null
./repo-pull-clone.sh 
cd - 1> /dev/null
```


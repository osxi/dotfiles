dotfiles
========

This is my collection of dotfiles that I can't live without.

Installation
========
1. link dotfiles/.vimrc to ~/.vimrc
2. link dotfiles/.vim/ to ~/.vim
3. Install Powerline via `pip install --user git+git://github.com/Lokaltog/powerline`
4. Make sure you have Powerline-friendly fonts installed

Vim
========
My Vim config. Most of the plugins used exist in this repository as submodules.

Pathogen
--------
`runtimepath` manager by tpope. Automatically loads plugins out of the `bundle` directory.

See https://github.com/tpope/vim-pathogen

NERDTree
--------
Provides tree-based filesystem navigation.

- To toggle `:NERDTree`, use `<F1>`.
- Uses ~/+ and displays lines instead of arrows via `NERDTreeDirArrows=0`
- 'Press ? for help' is hidden via `NERDTreeMinimalUI=1`

See https://github.com/scrooloose/nerdtree

Powerline
--------
Provides useful statslines for most helpful applications such as Zsh, tmux, and Vim. In my configuration, Vim will look for `~/.local/lib/python3.4/...` for bindings and if that directory doesn't exist because you're using a different version of Python ,Vim will attempt to use `~/.local/lib/python*-*/`, which will hopefully match something on your system. Otherwise, Powerline will look stupid and you'll know where to look as far as fixing it.

See https://github.com/Lokaltog/powerline and http://powerline.readthedocs.org/en/latest/

vim-colors-solarized
--------
Solarized colorscheme. Works pretty well in terminal (non-g) Vim.

See https://github.com/altercation/vim-colors-solarized

Fugitive
--------
Git wrapper.

- To toggle `:Gblame` (blame), use `<C-b>`
- To open `:Gdiff` (diff), use `<C-d>`
- To toggle `:Gstatus` (status), use `<C-a>`

See https://github.com/tpope/vim-fugitive

Miscellaneous .vimrc settings
--------
- Cursor highlighting
- 2-space tabs
- Line numbers
- Mouse: mouse=a (all modes)
- Syntax highlighting
- Column 80 well (darkened)
- Matching braces/quotes automatically inserted

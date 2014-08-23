" Load pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Toggle NERDTree
map <F1> :NERDTreeToggle<CR>

" Cursor highlight
set cursorline
set cursorcolumn

" Use 2 spaces for tabs
set tabstop=2
set expandtab
set shiftwidth=2
"set smartindent
"set cindent

" Line numbers
set nu
highlight LineNr ctermfg=white ctermbg=238

" Mouse support in all modes
set mouse=a

" Syntax highlighting
syntax on

" Powerline
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" Autoindent
set autoindent

" Solarized color scheme
" https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Highlight column 80
" set cc=80

" Highlight columns 80+
highlight ColorColumn ctermbg=233 guibg=#121212
let &colorcolumn=join(range(81,999),",")

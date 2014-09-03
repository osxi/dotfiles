" Load pathogen
if $VIM_PATHOGEN == '1'
  runtime bundle/vim-pathogen/autoload/pathogen.vim
  execute pathogen#infect()
endif

" Toggle NERDTree
map <F1> :NERDTreeToggle<CR>

" Show lines instead of arrows
let NERDTreeDirArrows=0

" Hide 'Press ? for help'
let NERDTreeMinimalUI=1

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
if !empty(glob("$HOME/.local/lib/python3.4"))
  " Use 3.4 bindings preferably
  set rtp+=$HOME/.local/lib/python3.4/site-packages/powerline/bindings/vim/
else
  " Use any Python if 3.4 bindings not found
  set rtp+=$HOME/.local/lib/python*.*/site-packages/powerline/bindings/vim/
endif

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

" Automatically insert matching braces and quotes
inoremap { {}<Esc>:let leavechar="}"<CR>i
inoremap ( ()<Esc>:let leavechar=")"<CR>i
inoremap [ []<Esc>:let leavechar="]"<CR>i
inoremap ' ''<Esc>:let leavechar="'"<CR>i
inoremap " ""<Esc>:let leavechar="""<CR>i

" Fugitive
map <C-b> :Gblame<CR>
map <C-d> :Gdiff<CR>
map <C-a> :Gstatus<CR>

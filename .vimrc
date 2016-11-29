" Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go'
Plug 'jiangmiao/auto-pairs'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-commentary'
call plug#end()

" Misc
autocmd BufWritePre * %s/\s\+$//e
:imap jj <Esc>
nnoremap <Left> <C-w>>
nnoremap <Right> <C-w><
set nu
set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set laststatus=2
set autowrite
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" NERDTree
map <C-e> :NERDTreeToggle<CR>

" undotree
if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif
nnoremap <C-i> :UndotreeToggle<cr>

" ctrlp
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" airline
let g:airline#extensions#tabline#enabled = 1

" Ellis Gray vimrc

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Plugin 'gmarik/vundle'

Plugin 'tpope/vim-fugitive'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-rails'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-commentary'
Plugin 'ervandew/supertab'
Plugin 'thoughtbot/vim-rspec'
Plugin 'danro/rename.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'slim-template/vim-slim'
Plugin 'godlygeek/tabular'

call vundle#end()
filetype plugin indent on

" Settings
let mapleader = ','
syntax on
colorscheme railscasts
:let &colorcolumn=join(range(101,101),",")

set splitbelow
set splitright
set hidden
set showmatch
set history=10000
set number
set relativenumber
set autoread
set lazyredraw
set ttyfast
set hlsearch
set cursorline
set scrolloff=3
set ignorecase
set nobackup
set noswapfile
set tabstop=2
set shiftwidth=2
set re=1
set eol
set expandtab
set backspace=indent,eol,start
set shell=bash
" Set termcap mode
set t_ti= t_te=
let &t_Co=256

" Autocmds

autocmd BufWritePre * :%s/\s\+$//e

" Keymappings

" I want to use ; instead of : and I want the original ; as ;;
map ; :
noremap ;; ;

" Remove hlsearch quickly
noremap <leader>h :nohlsearch<cr>

" Splits navigation with ctrl+hjkl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Splits creation

" window
nmap <leader>swh  :topleft vnew<cr>
nmap <leader>swl  :botright vnew<CR>
nmap <leader>swk  :topleft  new<CR>
nmap <leader>swj  :botright new<CR>
" buffer
nmap <leader>sh   :leftabove  vnew<CR>
nmap <leader>sl   :rightbelow vnew<CR>
nmap <leader>sk   :leftabove  new<CR>
nmap <leader>sj   :rightbelow new<CR>

nmap <leader>w    <c-w>=

" Commentary comment block
vnoremap <leader>/ :Commentary<cr>

" Rspec vim
map <leader>t :call RunCurrentSpecFile()<cr>
map <leader>s :call RunNearestSpec()<cr>
map <leader>l :call RunLastSpec()<cr>
" map <leader>a :call RunAllSpecs()<cr>
let g:rspec_command = "!bundle exec rspec {spec}"


" Open alternative file
nnoremap <leader><leader> <C-^>

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{fugitive#statusline()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" Airline
set laststatus=2

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled=1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = '⎇'
let g:airline#extensions#whitespace#enabled = 1
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'

" Tabular mappings (default)

nmap <leader>a= :Tabularize /=<cr>
vmap <leader>a= :Tabularize /=<cr>
nmap <leader>a: :Tabularize /:\zs<cr>
vmap <leader>a: :Tabularize /:\zs<cr>

" Ellis Gray vimrc

set encoding=utf-8
set nocompatible
filetype off

call plug#begin()

Plug 'janko/vim-test' " Ruby tests

" Git/Version Control
Plug 'tpope/vim-fugitive'         " GBlame
Plug 'tpope/vim-rhubarb'          " GBrowse
Plug 'rbong/vim-flog'             " FlogSplit (branch-viewer)
Plug 'airblade/vim-gitgutter'     " Show git diff of lines edited

" Ruby / Rails
Plug 'tpope/vim-endwise'          " Autocomplete end after a do
Plug 'slim-template/vim-slim'     " Slim Views


" Various status bar things branch/filename/dirty-state
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Alternative to CtrlP
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'           " Set up fzf and fzf.vim

" Themes
Plug 'jpo/vim-railscasts-theme' " Can't change now..

" Language stuff
Plug 'elixir-lang/vim-elixir'
Plug 'stephpy/vim-yaml'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'styled-components/vim-styled-components' " Sounds good?

" Code Completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'scrooloose/syntastic'

" Misc
Plug 'ervandew/supertab'          " Tab completion
Plug 'psliwka/vim-smoothie'       " Smooth scrolling
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'  " <leader>s find

" Maybe Dep?
Plug 'tomtom/tlib_vim'

call plug#end()
filetype plugin indent on

" Quickly make it so
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

" Settings
let mapleader = ','
syntax on
colorscheme railscasts
hi Normal guibg=NONE ctermbg=NONE

let &colorcolumn=join(range(101,101),",")
let g:snipMate = { 'snippet_version' : 1 }

set background=dark
set ttyfast
set lazyredraw
set updatetime=300
set signcolumn=yes
set hidden
set number
set numberwidth=4
set ruler
set cursorline
set mouse=nvi

" set <F5> set invpaste paste?<CR>

set showmode
set showmatch
set showcmd

set autoindent
set cindent
set smartindent

set foldmethod=syntax
set foldlevel=99

set shiftwidth=2
set tabstop=2
set scrolloff=3
set softtabstop=2
set expandtab

set nobackup
set noswapfile
set nowritebackup

set ignorecase " Ignore case when searching
set smartcase  " When searching try and be smart about cases
set nohlsearch " Don't highlight search term??
set incsearch  " Jumping to next search

set laststatus=2 " Always show status line (Airline)

" Allow copy+paste from system clipboard
set clipboard=unnamed

" Spellcheck for markdown
au BufRead,BufNewFile *.md setlocal spell

nnoremap <silent><leader>2 :e ~/.vimrc<CR>

set splitbelow
set splitright
set history=10000
set autoread
set hlsearch
set eol
set backspace=indent,eol,start
set shell=bash
set nohidden
" Set termcap mode
set t_ti= t_te=
let &t_Co=256

set rtp+=~/.fzf

" Map fzf search to CtrlP
nnoremap <C-p> :GFiles<Cr>

" Map fxf + ag search to Ctrl P
nnoremap <C-g> :Rg <Cr>

" Extra <CR> is for disabling /"Press ENTER or type command to continue/"
nnoremap <silent><leader>e :Exp<CR><CR>


" CoC extensions

let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json']


" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

inoremap <silent><expr> <c-space> coc#refresh()

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
nnoremap <silent> K :call ShowDocumentation()<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>c  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Format
nmap <leader>f   :CocCommand prettier.formatFile<CR>


" Fix some weird error with Fugitive
let g:fugitive_pty = 0

" Delete empty lines after save
autocmd BufWritePre * :%s/\s\+$//e

" Fix syntax highlight for Coc plugin floating errors
hi CocErrorFloat guifg=Magenta guibg=Magenta

" Syntastic settings
syntax enable
set statusline+=%#warningmsg#
set statusline+=%{fugitive#statusline()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

" Keymappings

" I want to use ; instead of : and I want the original ; as ;;
map ; :
noremap ;; ;

" Remove hlsearch quickly
noremap <leader>h :nohlsearch<cr>
" copy
nnoremap <C-Y> "*y
vnoremap <C-Y> "*y


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

" Open alternative file
nnoremap <leader><leader> <C-^>

" Easy Motion stomping on my alternative file
map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-s)

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{fugitive#statusline()}
set statusline+=%*

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

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
Plug 'romainl/Apprentice'
Plug 'jacoborus/tender.vim'

" Language stuff
Plug 'elixir-lang/vim-elixir'
Plug 'stephpy/vim-yaml'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'styled-components/vim-styled-components' " Sounds good?

" ALE
Plug 'dense-analysis/ale'
Plug 'ycm-core/YouCompleteMe'

" Code Completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'scrooloose/syntastic'

" Misc
" Plug 'ervandew/supertab'          " Tab completion
Plug 'psliwka/vim-smoothie'       " Smooth scrolling
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'  " <leader>s find

" Maybe Dep?
Plug 'tomtom/tlib_vim'

call plug#end()
filetype plugin indent on

" Settings
let mapleader = ','
syntax on
colorscheme railscasts

if (has("termguicolors"))
 set termguicolors
endif

autocmd FileType c colorscheme tender
hi Normal guibg=NONE ctermbg=NONE

let &colorcolumn=join(range(101,101),",")
let g:snipMate = { 'snippet_version' : 1 }

let g:ale_cpp_clang_format_options = '-style=file'

let g:ale_linters = {
      \ 'c': ['clang-tidy'],
      \ 'h': ['clang-tidy'],
      \ 'cpp': ['clang-tidy'],
      \ 'ruby': ['rubocop'],
      \ 'ruby_on_rails': ['rubocop'],
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines'],
      \ 'yaml': ['prettier'],
      \ 'c': ['clang-format'],
      \ 'h': ['clang-format'],
      \ 'cpp': ['clang-format'],
      \ 'ruby': ['rubocop'],
      \ }
let g:ale_fix_on_save = 1
let g:ale_set_quickfix = 0
let g:ale_hover_cursor = 1
let g:ale_hover_to_preview = 1
let g:ale_completion_enabled = 1

let g:ycm_enable_semantic_highlighting=1

imap <silent> <C-l> <Plug>(YCMToggleSignatureHelp)
nnoremap <leader>jd :YcmCompleter GoTo<CR>

let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_ruby_rubocop_options = '-D'

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

" Spellcheck for markdown
au BufRead,BufNewFile *.md,*.rb,*.js,*.ts,*.tsx,*.jsx setlocal spell

nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>
nnoremap <silent><leader>2 :e ~/.vimrc<CR>

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

" " Automatically format code on save
function! FormatAndSave()
  let save_cursor = getpos('.')
  echo save_cursor
  normal gg=G
  call setpos('.', save_cursor)
endfunction

autocmd BufWritePre *.c,*.h,*.cpp call FormatAndSave()

function! Bin2Hex()
  let cursor = getpos('.')

  normal! B
  let start_c = col('.')
  normal! e
  let end_c = col('.')

  let bin_num = getline('.')[start_c - 1:end_c - 1]

  let dec_num = str2nr(bin_num, 2)

  let hex_num = printf("0x%X", dec_num)

  call setline('.', substitute(getline('.'), '\<' . bin_num . '\>', hex_num, ''))
  call setpos('.', cursor)
endfunction
nnoremap <Leader>X :call Bin2Hex()<CR>

function! Bin2Dec()
  let cursor = getpos('.')

  normal! B
  let start_c = col('.')
  normal! e
  let end_c = col('.')

  let bin_num = getline('.')[start_c - 1:end_c - 1]

  let dec_num = str2nr(bin_num, 2)

  call setline('.', substitute(getline('.'), '\<' . bin_num . '\>', dec_num, ''))
  call setpos('.', cursor)
endfunction
nnoremap <Leader>D :call Bin2Dec()<CR>

function Num2Bin()
  let num = expand('<cword>')

  if !empty(num)
    let binary = printf('%b', num)
    execute 'silent! normal! diw'
    execute 'silent! normal! i' . '0b' . binary
  endif
endfunction
nnoremap <Leader>B :call Num2Bin()<CR>
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
" iunmap <Tab>
" iunmap <S-Tab>
inoremap <expr> <Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<c-p>" : "\<S-Tab>"

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
let g:airline#extensions#ale#enabled = 1
let g:coc_disable_mappings_check = 1

" Tabular mappings (default)
nmap <leader>a= :Tabularize /=<cr>
vmap <leader>a= :Tabularize /=<cr>
nmap <leader>a: :Tabularize /:\zs<cr>
vmap <leader>a: :Tabularize /:\zs<cr>

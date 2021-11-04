" Leader
let mapleader = ","

" vim-plug: Vim plugin manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:ale_disable_lsp = 1  " coc for lsp

call plug#begin('~/.vim/bundle')
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'junegunn/fzf'
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'elixir-editors/vim-elixir'
Plug 'rizzatti/dash.vim'
Plug 'renderedtext/vim-bdd'
Plug 'slim-template/vim-slim'
Plug 'altercation/vim-colors-solarized'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'dense-analysis/ale'
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'

"" to check
" Bundle 'tpope/vim-rsi'

call plug#end()

" Colorscheme
" https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
let &t_ut=''
syntax enable
set background=dark
colorscheme iceberg
set termguicolors

set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation
set laststatus=2                " Always show the statusline
set hidden                      " Maintain scroll position (don't close buffer)
runtime macros/matchit.vim      " Needed for Ruby block selection support: https://github.com/nelstrom/vim-textobj-rubyblock

set ofu=syntaxcomplete#Complete

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set listchars=trail:·,tab:▸\ ,eol:¬

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter


"" Line numbering, cursor
"set relativenumber                " Show relative line numbers
set number                        " Show current line number
set numberwidth=5
set scrolloff=3                   " Show 3 lines of context around the cursor.

" Markdown
autocmd! BufRead *.mkd set ai formatoptions=tcroqn2 comments=n:> ft=markdown
autocmd! BufRead *.md set ai formatoptions=tcroqn2 comments=n:> ft=markdown
autocmd! BufRead *.mdown set ai formatoptions=tcroqn2 comments=n:> ft=markdown
autocmd! BufRead *.markdown set ai formatoptions=tcroqn2 comments=n:> ft=markdown

" CSS3
au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile *.css set ft=css syntax=css

" HTML5
au BufRead,BufNewFile *.html set ft=html syntax=html
au BufRead,BufNewFile *.hbs set ft=html syntax=html
au BufRead,BufNewFile *.mustache set ft=html syntax=html
au BufRead,BufNewFile *.haml set ft=haml

au BufRead,BufNewFile *.js set ft=javascript syntax=javascript
au BufRead,BufNewfile *.rb set ft=ruby syntax=ruby

" The Silver Searcher
if executable("ag")
  " Use ag over Ack
  let g:ackprg = 'ag --nogroup --nocolor --column'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :Ag <C-R><C-W><CR>

" because of missclicks ;)
command Q q
command Wq wq
command W w

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>

"" Yankring
let g:yankring_history_file = '.yankring_history'
map <Leader>y :YRShow<cr>

"" NERDTree
function! ShowFileInNERDTree()
  if exists("t:NERDTreeBufName")
    NERDTreeFind
  else
    NERDTree
    wincmd l
    NERDTreeFind
  endif
endfunction
map <Leader>d :call ShowFileInNERDTree()<cr>

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"" Wild stuff
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore+=vendor,log,tmp,*.swp,.git,gems,.bundle,Gemfile.lock,.gem,.rvmrc,.gitignore,.DS_Store,data

"" Misc shortcuts
nnoremap <Leader>\ :nohlsearch<cr>      " un-highlight search results
map <F5> :call system('pbcopy', @%)<cr> " Copy file path to clipboard
map <Leader>p :FZF<cr>

"" ctrl + hjkl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Get rid of the delay when hitting esc!
set noesckeys

set nocompatible

" For all text files set 'textwidth' to 81 characters.
autocmd FileType text setlocal textwidth=81
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=15 guibg=#592929
  autocmd BufEnter * match OverLength /\%81v.*/
augroup END

" Make the omnicomplete text readable
:highlight PmenuSel ctermfg=black

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

"" Disable arrow keys
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <C-x> <C-w>c
map <C-n> :cn<CR>
map <C-p> :cp<CR>

" Set the tag file search order
set tags=./tags;

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>n :call RenameFile()<cr>

" ESLint
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=\ %3*%{StatlineSyntastic()}%*
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_javascript_eslint_exec = 'eslint_d'

function! StatlineSyntastic()
  " safe guard against syntastic being only loaded after statline
  if exists('g:loaded_syntastic_plugin')
    return SyntasticStatuslineFlag()
  else
    return ''
  endif
endfunction

" https://github.com/garybernhardt/dotfiles/commit/99b7d2537ad98dd7a9d3c82b8775f0de1718b356
" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is
" significantly
" slower with the new regex engine.
set re=1

let g:snipMate = { 'snippet_version' : 1 }

let g:gitgutter_highlight_lines = 0
let g:gitgutter_signs = 1
let g:gitgutter_sign_allow_clobber = 0
" set signcolumn=number


" coc
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \}

" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes#For_VTE_compatible_terminals_.28urxvt.2C_st.2C_xterm.2C_gnome-terminal_3.x.2C_Konsole_KDE5_and_others.29_and_wsltty
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

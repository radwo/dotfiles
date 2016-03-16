" Leader
let mapleader = ","

""" Vundle config start
filetype off                   " required!

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"Add your bundles here
Bundle 'Lokaltog/vim-powerline'
Bundle 'Syntastic'
Bundle 'airblade/vim-gitgutter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'croaky/vim-colors-github'
Bundle 'juvenn/mustache'
Bundle 'kana/vim-textobj-user'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'scrooloose/nerdtree'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
"Bundle 'tpope/vim-rsi'
Bundle 'vim-ruby/vim-ruby'
Bundle 'elixir-lang/vim-elixir'
Bundle 'vim-scripts/TailMinusF'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'ngmy/vim-rubocop'
Bundle 'henrik/vim-ruby-runner'

"" vim-snipmate  dependencies
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"
Bundle "garbas/vim-snipmate"

"...All your other bundles...
if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :BundleInstall
endif
" Setting up Vundle - the vim plugin bundler end

""" Vundle config end

map <Leader>cn :e ~/Dropbox/notes/coding-notes.txt<cr>
map <Leader>pn :sp ~/Dropbox/work/infakt/notes/project-notes.txt<cr>
map <Leader>o :call RunCurrentLineInTest()<CR>
map <Leader>t :w<cr>:call RunCurrentTest()<CR>

"" General settings
syntax on

" Color scheme
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

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
set number                        " Show line numbers
set numberwidth=5
set ruler                         " Show cursor position.
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

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" because of missclicks ;)
command Q q
command Wq wq
command W w

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

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

"" Wild stuff
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set wildignore+=vendor,log,tmp,*.swp,.git,gems,.bundle,Gemfile.lock,.gem,.rvmrc,.gitignore,.DS_Store,data

"" Misc shortcuts
nnoremap <Leader>\ :nohlsearch<cr>      " un-highlight search results
map <F5> :call system('pbcopy', @%)<cr> " Copy file path to clipboard
map <Leader>p :CtrlP<cr>
map <Leader>b :CtrlPBuffer<cr>

"" ctrl + hjkl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Get rid of the delay when hitting esc!
set noesckeys

set nocompatible

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#CFCFCF
  autocmd BufEnter * match OverLength /\%78v.*/
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!bin/rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!bin/rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

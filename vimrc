set encoding=utf-8

" Pathogen vim package manager
execute pathogen#infect()
syntax on
filetype plugin indent on

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Install plug.vim if we don't have it
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"Things below here Blake Griffith has added
"
" show trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
" Show trailing whitespace:
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set backupdir=~/.vim/backups

filetype indent on
filetype plugin on
let g:tex_flavor='latex'

set tabstop=4 shiftwidth=4 expandtab
set softtabstop=4

" Remove ability to use arrow key. Habit breaking, habit making.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Latex-Suite stuff
" fix grep latex-suite incompatibilities
set grepprg=grep\ -nH\ $*

" Vim 7 loads empty .tex files as 'plaintex' instead of 'tex'. Fix this.
let g:tex_flavor='latex'

" Highlight searched terms
set hlsearch

" STOP. LaTeX stuff.
autocmd FileType tex set colorcolumn=72
autocmd FileType tex set tw=72

" c++ stuff
autocmd Filetype c++ nnoremap ,ra :CocAction <cr>
" python stuff
autocmd FileType python set colorcolumn=80
autocmd Filetype python nnoremap ,l :w \|:! clear && flake8 % <cr>

" sql stuff
autocmd Filetype sql set tabstop=2 shiftwidth=2 expandtab

" javascript stuff
autocmd Filetype javascript set tabstop=2 shiftwidth=2 expandtab
autocmd Filetype javascript set softtabstop=2
"autocmd Filetype javascript set foldmethod=syntax
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
    au Filetype javascript setlocal foldlevelstart=0
    au Filetype javascript setlocal nofoldenable
augroup END
autocmd Filetype javascript nnoremap ,l :w \|:! clear & \$\(npm bin\) <cr>
autocmd Filetype javascript nnoremap ,ra :CocAction <cr>
autocmd Filetype javascriptreact set tabstop=2 shiftwidth=2 expandtab
autocmd Filetype javascriptreact nnoremap ,ra :CocAction <cr>

" js code fold not working. Trying this. Taken from: https://stackoverflow.com/a/71345892/1609380
"let g:javaScript_fold = 1

" typescript stuff
autocmd Filetype typescript set tabstop=2 shiftwidth=2 expandtab

autocmd Filetype typescriptreact set tabstop=2 shiftwidth=2 expandtab
autocmd Filetype typescriptreact nnoremap ,ra :CocAction <cr>
autocmd Filetype typescript nnoremap ,ra :CocAction <cr>


" rust stuff
autocmd Filetype rust nnoremap ,ra :CocAction <cr>
autocmd Filetype rust nnoremap ,o :CocCommand rust-analyzer.openDocs <cr>
let g:rust_fold = 1

" .yaml stuff
autocmd Filetype yaml set tabstop=2 shiftwidth=2 expandtab
autocmd Filetype yaml set softtabstop=2

" go stuff
autocmd Filetype go set tabstop=4 noexpandtab

" put cursor on first line of git commit in vim
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" use tab to switch buffers
nnoremap <Tab> :bnext <cr>
" use tab to switch buffers
nnoremap <S-Tab> :bprevious <cr>

" underline cursorline
set cursorline
hi CursorLine ctermbg=Black cterm=None

" vertical line through cursor
set cursorcolumn

" set the <leader> to ','
let mapleader = ","

" use ,n to change tabs
nnoremap ,n :w \|:tabNext <cr>

" leader q to close buffer but not the window
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" ,w to save
map ,w :w <cr>
" ,b to close buffer
map <leader>b :BD<CR>


"
" run `!!` command in most recently opened terminal buffer
map <leader>p :w \|:RerunLastThingInLastTerminal <cr>

" run Ctrl-c command in most recently opened terminal buffer
map <leader>c :w \|:CancelInLastTerminal <cr>

" below is what we used before vim terminal
" TODO find a way to user tmux pane instead of vim terminal automatically
" send Ctrl-c to neighboring tmux pane
"map ,c :w \|:! tmux send-keys -t 0:$(tmux display-message -p '\#I').1 C-c <cr><cr>
" run `!!` command in the neighboring tmux pane
map ,t :w \|:! tmux send-keys -t 0:$(tmux display-message -p '\#I').1 C-l C-u "\!\!" Enter Enter <cr><cr>

" show line numbers
set nu

" unlimited undo4eva
set undodir=~/.vim/undodir
set undofile

set history=10000

colorscheme gruvbox

call plug#begin('~/.vim/plugged')

" Install development version coc.vim - the language server extension host
" copied from https://github.com/neoclide/coc.nvim#quick-start
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" Initialize plugin system
call plug#end()

function! SingleSpace()
    %s/\n\n/\r/g
endfunction

let g:vim_vue_plugin_use_typescript	= 1

" from coc.vim docs 
" https://github.com/neoclide/coc.nvim

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" auto-import from autocomplete menu
" from here: https://github.com/fannheyward/coc-pyright/issues/445
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" rename symbol under cursor
nmap <leader>rn <Plug>(coc-rename)

" refactor current symbol
nmap <leader>rr <Plug>(coc-refactor)

nmap <leader>ac <Plug>(coc-codeaction-cursor)
nmap <leader>al <Plug>(coc-codeaction-line)
vmap <leader>as <Plug>(coc-codeaction-selected)

nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>

" seleting file in Netrw directory listing closes the Netrw buffer
" https://vi.stackexchange.com/a/20111/37637
let g:netrw_fastbrowse = 0

"make Ctrl-w w work as usual when in insert mode in terminal
"much nicer on the firngers than Ctrl-\ Ctrl-n
tnoremap <C-W><C-W> <C-\><C-n><C-W><C-W>
"clear the scrollback in the terminal buffer
nmap <c-w><c-l> :set scrollback=1 \| sleep 100m \| set scrollback=10000<cr>
tmap <c-w><c-l> <c-\><c-n><c-w><c-l>i<c-l>

" Spell-check Markdown
autocmd FileType markdown setlocal spell
" enable autocomplet for spelling
autocmd FileType markdown setlocal complete+=kspell

" Spell-check Commit Messages
autocmd FileType gitcommit setlocal spell
" enable autocomplet for spelling
autocmd FileType gitcommit setlocal complete+=kspell

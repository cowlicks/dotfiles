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

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
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
match ExtraWhitespace /\s\+$/
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

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

" python stuff
autocmd FileType python set colorcolumn=80
autocmd Filetype python nnoremap ,l :w \|:! clear && flake8 % <cr>

" javascript stuff
autocmd Filetype javascript set tabstop=2 shiftwidth=2 expandtab
autocmd Filetype javascript set softtabstop=2
autocmd Filetype javascript nnoremap ,l :w \|:! clear && eslint % <cr>

" typescript stuff
autocmd Filetype typescript set tabstop=4 shiftwidth=4 expandtab

" .yaml stuff
autocmd Filetype yaml set tabstop=2 shiftwidth=2 expandtab
autocmd Filetype yaml set softtabstop=2

" go stuff
autocmd Filetype go set tabstop=4 noexpandtab

" put cursor on first line of git commit in vim
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" use tab to switch buffers
nnoremap <tab> :w \|:bnext <cr>

" underline cursorline
set cursorline
hi CursorLine ctermbg=Black cterm=None

" use ,n to change tabs
nnoremap ,n :w \|:tabNext <cr>

" leader q to close buffer but not the window
nnoremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" ,w to save
map ,w :w <cr>
" ,b to close buffer
map ,b :bd <cr>

" show line numbers
set nu

" unlimited undo4eva
set undodir=~/.vim/undodir
set undofile

set history=10000

colorscheme gruvbox

" for typescript suff
autocmd FileType typescript TsuReload

function! SingleSpace()
    %s/\n\n/\r/g
endfunction

" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim
set nocompatible

"" FIX ISSUES WITH iMacs terminal transparencys
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termtrans=1
let g:solarized_termcolors=256
"set t_Co=16

"" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
          source /etc/vim/vimrc.local
  endif

" display settings
set encoding=utf-8 " encoding used for displaying file
set ruler " show the cursor position all the time
set showmatch " highlight matching braces
set showmode " show insert/replace/visual mode
set number
set nowrap   " Line wrapping gets annoying when you have small windows.
set listchars=trail:·,nbsp:·  " Show trailing white space

"maximize window area
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" disable audio bells
set noerrorbells
set novisualbell
set t_vb=

" write settings
set confirm " confirm :q in case of unsaved changes
set fileencoding=utf-8 " encoding used when saving file
set nobackup " do not keep the backup~ file

" edit settings
set backspace=indent,eol,start " backspacing over everything in insert mode
"set expandtab " fill tabs with spaces
"set nojoinspaces " no extra space after '.' when joining lines
set shiftwidth=4 " set indentation depth to 4 columns
set softtabstop=4 " backspacing over 4 spaces like over tabs
set tabstop=4 " Tabs should always be 4 spaces
"set textwidth=80 " wrap lines automatically at 80th column
set autoindent
set copyindent
set smartindent

" search settings
set hlsearch " highlight search results
set ignorecase " do case insensitive search...
set incsearch " do incremental search
set smartcase " ...unless capital letters are used

set wildmode=list:longest,full " gives tab completion lists in ex command area
set wildmenu
"" Ignore dist and build folders
set wildignore+=*/dist*/**,*/target/**,*/build*/**
" Ignore libs
set wildignore+=*/lib/**,*/node_modules/**,*/bower_components/**,*/locale/**
" Ignore images, pdfs, and font files
set wildignore+=*.png,*.PNG,*.jpg,*.jpeg,*.JPG,*.JPEG,*.pdf
set wildignore+=*.ttf,*.otf,*.woff,*.woff2,*.eot
set magic " Use extended regular expressions
" file type specific settings
filetype on " enable file type detection
filetype plugin on " load the plugins for specific file types
filetype indent on " automatically indent code

" syntax highlighting
colorscheme solarized " set color scheme, must be installed first
set background=dark " dark background for console
syntax enable " enable syntax highlighting

" characters for displaying non-printable characters
set listchars=eol:$,tab:>-,trail:.,nbsp:_,extends:+,precedes:+

" tuning for gVim only
if has('gui_running')
        set background=dark " light background for GUI
        set columns=84 lines=48 " GUI window geometry
        set guifont=Monospace\ 12 " font for GUI window
        set number " show line numbers
endif

" automatic commands
if has('autocmd')
        " file type specific automatic commands

        " tuning textwidth for Java code
        autocmd FileType java setlocal textwidth=132
        if has('gui_running')
                autocmd FileType java setlocal columns=136
        endif

        " don't replace Tabs with spaces when editing makefiles
        autocmd Filetype makefile setlocal noexpandtab

        " disable automatic code indentation when editing TeX and XML files
        autocmd FileType tex,xml setlocal indentexpr=

        " clean-up commands that run automatically on write; use with caution

        " delete empty or whitespaces-only lines at the end of file
        autocmd BufWritePre * :%s/\(\s*\n\)\+\%$//ge

        " replace groups of empty or whitespaces-only lines with one empty line
        autocmd BufWritePre * :%s/\(\s*\n\)\{3,}/\r\r/ge

        " delete any trailing whitespaces
        autocmd BufWritePre * :%s/\s\+$//ge
endif

" general key mappings

" center view on the search result
noremap n nzz
noremap N Nzz
" find and replace with just S
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>
" press F4 to fix indentation in whole file; overwrites marker 'q' position
noremap <F4> mqggVG=`qzz
inoremap <F4> <Esc>mqggVG=`qzza

" press F5 to sort selection or paragraph
vnoremap <F5> :sort i<CR>
nnoremap <F5> Vip:sort i<CR>

" press F8 to turn the search results highlight off
noremap <F8> :nohl<CR>
inoremap <F8> <Esc>:nohl<CR>a

" switch between tabs
nmap <F7> gt
nmap <F6> gT


" Stripping trailing whitespace
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e

" quickly move line up or down
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" session write map
map <F2> :mksession! ~/.vim/sessions/session.vim <cr> " Quick write session with F2
map <F3> :source ~/.vim/sessions/session.vim <cr>     " And load session with F3

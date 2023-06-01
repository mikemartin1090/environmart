"Example taken from here: https://www.linode.com/docs/guides/introduction-to-vim-customization/#integrate-plug-ins

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Automatically wrap text that extends beyond the screen length.
set wrap

" Keep Linus happy
set textwidth=79

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Fixes common backspace problems
set backspace=indent,eol,start

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show line numbers
set number

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" iTerm (I guess) is not using the correct colors for vim. This fixes it.
" https://stackoverflow.com/a/64069936
set termguicolors

" Install plugin manager if it is not already
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



" The plugins I want to install
" Keep in mind that you will need to :PlugInstall after adding a new plugin in Vim
" Helpful: https://www.linode.com/docs/guides/introduction-to-vim-customization/#integrate-plug-ins
" https://www.linode.com/docs/guides/vim-color-schemes/#install-using-a-vim-plug-in-manager
call plug#begin('~/.vim/plugged')

" (coc.nvim) Intellesense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Theme I found here: https://vimcolorschemes.com/srcery-colors/srcery-vim
Plug 'srcery-colors/srcery-vim'

call plug#end()




" Need to declare colorscheme after its installed https://stackoverflow.com/a/64178519
" https://github.com/srcery-colors/srcery-vim#usage
colorscheme srcery

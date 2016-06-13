
execute pathogen#infect()

syntax on
filetype on
au BufNewFile,BufRead *.f95 setfiletype fortran
au BufNewFile,BufRead *.sage setfiletype python

set background=dark
colorscheme solarized

set tabstop=4
set shiftwidth=4
set expandtab
" lowercase is insensitive, a capital makes it case sensitive
" overrride with \c or \C
set smartcase
set ignorecase
" use perl/python regex
nnoremap / /\v
vnoremap / /\v

" make backspace work normally...
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=2

" put a vertical line at the 86th column
" this column is the first column I can't see when there are 3 terminals side by side in i3
set colorcolumn=81
color delek
" make the column line almost black (must come after 'color delek')
highlight ColorColumn ctermbg=8
" color search matches
set hlsearch
" underline, not color spelling highlights
highlight clear SpellBad
highlight SpellBad cterm=standout

let g:EasyMotion_leader_key = '<Leader>'

set t_ut=



" for eclim
set nocompatible
filetype plugin on

call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
call plug#end()

" Syntax
let g:hybrid_custom_term_colors = 1
set background=dark
colorscheme hybrid_material
syntax enable

" vim-go
let g:go_auto_sameids = 1

se mouse=""
se nu
se ts=2
se sw=2
se expandtab

" Workaround for konsole
set guicursor=

let g:go_fmt_command = "goimports"

au FileType gitcommit set tw=72
filetype plugin indent on

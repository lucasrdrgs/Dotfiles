# You may need to install gvim instead of Vim to get the yank & paste fully working with system clipboard.
set number hls ic is cin ci pi
autocmd!
autocmd FileType * set tabstop=4
autocmd FileType * set shiftwidth=4
autocmd FileType * set noexpandtab
set mouse=n
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
filetype plugin on
filetype plugin indent on
syntax on

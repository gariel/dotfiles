" Editor
set nu
set expandtab
set list
set hidden
set tabstop=4
set softtabstop=4
set shiftwidth=4
set laststatus=0

call plug#begin('~/.local/share/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-scripts/indentpython.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-syntastic/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'ap/vim-buftabline'
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

call plug#end()

" deoplete
let g:deoplete#enable_at_startup = 1
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction
function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree
map <A-S-L> :NERDTreeFind<CR>
map <A-1> :NERDTreeToggle<CR>
let NERDTreeHijackNetrw=1
let NERDTreeShowHidden=1

" key mapping
map <C-a> <Nop>
nnoremap <A-]> :bnext<CR>
nnoremap <A-[> :bprev<CR>
inoremap <A-]> :bnext<CR>
inoremap <A-[> :bprev<CR>

nnoremap <C-w> :bp\|bd #<CR>
inoremap <C-w> :q<CR>

noremap <C-J> <C-W><C-J>
inoremap <C-J> <Esc><C-W><C-J>

noremap <C-K> <C-W><C-K>
inoremap <C-K> <Esc><C-W><C-K>

noremap <C-L> <C-W><C-L>
inoremap <C-L> <Esc><C-W><C-L>

noremap <C-H> <C-W><C-H>
inoremap <C-H> <Esc><C-W><C-H>

noremap <C-S-Up> :m-2<CR>
noremap <C-S-Down> :m+<CR>
inoremap <C-S-Up> <Esc>:m-2<CR>
inoremap <C-S-Down> <Esc>:m+<CR>

noremap <leader>= :set list!<CR>

"CtrlSF
nmap <C-S-f> <Plug>CtrlSFCwordPath
imap <C-S-f> <Plug>CtrlSFCwordPath
vmap <C-S-f> <Plug>CtrlSFVwordPath
map <leader>f :CtrlSFToggle<CR>
let g:ctrlsf_auto_focus = {"at": "start"}
"let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_search_mode = 'async'

" statusline
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_aggregate_errors = 1
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'gometalinter']
let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }


" Python
au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set textwidth=160
    \set expandtab
    \set autoindent
    \set fileformat=unix

" Front end
au BufNewFile,BufRead *.js, *.html, *.css
    \set tabstop=2
    \set softtabstop=2
    \set shiftwidth=2

" GoLang
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_type_info = 1
let g:go_snippet_engine = "neosnippet"
let g:go_fmt_command = "goimports"
let g:go_auto_sameids = 1

au FileType go nmap <leader>t :GoTest<CR>
au FileType go nmap <leader>r :GoRename<CR>
au FileType go nmap <F12> :GoDef<CR>
au FileType go nmap <C-S-F12> :GoDefpop<CR>
au FileType go nmap <C-F12> :GoImplements<CR>
au FileType go nmap <S-F12> :GoReferrers<CR>
"au FileType go silent exe GoGuruScope current_package/...

"Comenter
let g:NERDCommentEmptyLines = 1
nnoremap <C-/> :NERDComToggleComment<CR>
inoremap <C-/> :NERDComToggleComment<CR>

" auto pair
let g:AutoPairsShortcutToggle = ''

" ctrl p
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

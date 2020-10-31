" Set this to 1 to use ultisnips for snippet handling
let s:using_snippets = 0

" vim-plug: {{{
call plug#begin('~/.vim/plugged')

Plug 'ervandew/supertab'
Plug 'kien/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-buftabline'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

" C#
Plug 'omnisharp/omnisharp-vim'
Plug 'nickspoons/vim-sharpenup'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/asyncomplete.vim'

" Colorscheme
Plug 'gruvbox-community/gruvbox'

" Statusline
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'maximbaz/lightline-ale'

" Snippet support
if s:using_snippets
  Plug 'sirver/ultisnips'
endif

call plug#end()
" }}}

" Settings: {{{
filetype indent plugin on
if !exists('g:syntax_on') | syntax enable | endif
set encoding=utf-8
scriptencoding utf-8


set completeopt=menuone,noinsert,noselect,popuphidden
set completepopup=highlight:Pmenu,border:off

set nu
set backspace=indent,eol,start
set expandtab
set shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4
set textwidth=80
set title
set laststatus=0

set hidden
set nofixendofline
set nostartofline
set splitbelow
set splitright

set hlsearch
set incsearch
set ignorecase
set autoread
set nonumber
set noruler
set noshowmode
set signcolumn=yes

set mouse=a
set updatetime=1000
" }}}

" Colors: {{{
augroup ColorschemePreferences
  autocmd!
  " These preferences clear some gruvbox background colours, allowing transparency
  autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
  " Link ALE sign highlights to similar equivalents without background colours
  autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
  autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
  autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END

" Use truecolor in the terminal, when it is supported
if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme gruvbox
" }}}

" ALE: {{{
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'w'
let g:ale_sign_info = 'i'
let g:ale_sign_style_error = 'S'
let g:ale_sign_style_warning = '.'

let g:ale_linters = { 'cs': ['OmniSharp'] }
" }}}

" Asyncomplete: {{{
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
" }}}

" Sharpenup: {{{
" All sharpenup mappings will begin with `<Space>os`, e.g. `<Space>osgd` for
" :OmniSharpGotoDefinition
let g:sharpenup_map_prefix = '<Space>os'

let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
let g:sharpenup_statusline_opts.Highlight = 0

augroup OmniSharpIntegrations
  autocmd!
  autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
augroup END
" }}}

" Lightline: {{{
let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'active': {
\   'right': [
\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\     ['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
\   ]
\ },
\ 'inactive': {
\   'right': [['lineinfo'], ['percent'], ['sharpenup']]
\ },
\ 'component': {
\   'sharpenup': sharpenup#statusline#Build()
\ },
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok'
  \  },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right'
\  }
\}
" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "
" }}}

" OmniSharp: {{{
let g:OmniSharp_server_type = 'roslyn' 
let g:OmniSharp_prefer_global_sln = 1  
let g:OmniSharp_timeout = 10   

let g:OmniSharp_typeLookupInPreview = 1
let g:OmniSharp_popup_position = 'peek'
if has('nvim')
  let g:OmniSharp_popup_options = {
  \ 'winhl': 'Normal:NormalFloat'
  \}
else
  let g:OmniSharp_popup_options = {
  \ 'highlight': 'Normal',
  \ 'padding': [0, 0, 0, 0],
  \ 'border': [1]
  \}
endif
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}

if s:using_snippets
  let g:OmniSharp_want_snippet = 1
endif

let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}
" }}}



" Ctrl+P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rwa'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


"KeyBindings
nnoremap <F12> :OmniSharpGotoDefinition<cr>
nnoremap <C-F12> :OmniSharpFindImplementations<cr>
nnoremap <S-F12> :OmniSharpFindUsages<cr>
nnoremap <F2> :OmniSharpRename<cr>
nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
nnoremap <leader><cr> :OmniSharpGetCodeActions<cr>
nnoremap <leader><space> :OmniSharpSignatureHelp<cr>:

map <C-a> <Nop>
noremap <leader>. :bnext<CR>
noremap <leader>, :bprev<CR>

noremap <C-w> :bp\|bd #<CR>

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

"Super tab settings
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1


" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree
map <leader>0 :NERDTreeFind<CR>
map <leader>1 :NERDTreeToggle<CR>
"let NERDTreeHijackNetrw=1
let NERDTreeShowHidden=1

"Comenter
let g:NERDCommentEmptyLines = 1
nnoremap <leader>/ :NERDComToggleComment<CR>

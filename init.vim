" File: .vimrc

"  ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄
" ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█
"  ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄
"   ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"    ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"    ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"    ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒
"      ░░   ▒ ░░      ░     ░░   ░ ░
"       ░   ░         ░      ░     ░ ░
"      ░

" Optional Plugins
if has('nvim-0.5')
	packadd which-key.nvim   " Similar to spacemacs menu, works only on nvim 0.5
endif

" Colorscheme
let g:nord_italic = 1
let g:nord_underline = 1
colorscheme nord

" Basics {{{1
let mapleader =" "
set ignorecase smartcase     " ignorecase usless capital letter present
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set mouse=nv                  " mouse in normal and visual mode
set hidden

set splitbelow splitright    " splits right and below instead of left and above
set termguicolors
" 1}}}

" Editing {{{1
" highlight line with cursor
set cursorline
" highlight column 110 (guide)
set colorcolumn=110
" color of guide
highlight ColorColumn ctermbg=darkgrey

" Indentation Rules
set tabstop=4      " tab size
set softtabstop=4  " make space feel like a tab, will bs as if a tab
set shiftwidth=4   " indentation used for >>
set noexpandtab    " do not use spaces to fill tabs
set cindent        " automatic indentation for c programs

" perform dot commands over visual blocks
vnoremap . :normal .<CR>
" display tabs and trailing whitespace
set list listchars=tab:→\ ,trail:·,nbsp:·
" Disable auto commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Remove highlighted search results with enter
nnoremap <silent><Esc><Esc> :nohlsearch<CR>
" Spell-check set to <leader>o
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Relative line numbering (toggles off in insert mode)
set number relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" toggle fole with <CR> (same as za)
nnoremap <silent> <CR> @=(foldlevel('.')?'za':"\<Space>")<CR>
" fold method
set foldmethod=marker

" Ultisnips
let g:UltiSnipsExpandTrigger='<c-\>'
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-y>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical" 

" ALE
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)

" Completion {{{2
" command-mode completion settings
set wildmode=longest:full,full
" ignore case in cmd-mode
set wildignorecase
"enable omnicomplete
set omnifunc=syntaxcomplete#Complete
" suppress annoying messages.
set shortmess+=c
" settings for completion priority for C-n and C-p
set complete=.,w,b,u,i
" enable ale completion
let g:ale_completion_enabled = 1

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>
" 2}}}

" 1}}}

" Navigation {{{1
" Split navigation {{{2
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" move between splits in terminal mode
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
" resizing splits
noremap <silent> <C-m-u> :vertical resize +3<CR>
noremap <silent> <C-m-i> :resize -3<CR>
noremap <silent> <C-m-o> :resize +3<CR>
noremap <silent> <C-m-p> :vertical resize -3<CR>

" Start :terminal in insert mode
autocmd TermOpen * startinsert
" Open terminal buffer split (current dir)
nnoremap <leader>tt :below 15sp+te %:p:h<CR>
" Open terminal buffer split (working dir)
nnoremap <leader>ta :below 15sp+te<CR>
" esc+esc to exit terminal mode
tnoremap <ESC><ESC> <c-\><c-n>
" 2}}}

" File Manager (netrw) {{{2
let g:netrw_keepdir = 0  " Keep current directory and browsing directory synced
let g:netrw_winsize = 18  " Size of netrw buffer
let g:netrw_banner = 0  " Hide banner, toggle with I
let g:netrw_liststyle = 3  " Tree View
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'  " Hide dotfiles by default
let g:netrw_localcopydircmd = 'cp -r'  " Change cp to cp -r
let g:netrw_browse_split = 4  " Open file in previous active window
let g:netrw_preview = 1  " Preview splits
" Open netrw in current file path
nnoremap <leader>dd :Lexplore! %:p:h<CR>
" Open netrw in current working dir
nnoremap <Leader>da :Lexplore!<CR>

" Mappings to use in netrw
function! NetrwMapping()
	" go back in history
	nmap <buffer> H u
	" up a dir
	nmap <buffer> h -^
	" into a dir
	nmap <buffer> l <CR>

	" hidden files toggle
	nmap <buffer> . gh
	" close preview window
	nmap <buffer> P <C-w>z

	" open file and close netrw
	nmap <buffer> L <CR>:Lexplore!<CR>
	" toggle netrw
	nmap <buffer> <Leader>dd :Lexplore!<CR>

	" mark file
	nmap <buffer> <TAB> mf
	" unmark all files in current buffer
	nmap <buffer> <S-TAB> mF
	" unmark all files
	nmap <buffer> <Leader><TAB> mu

	" create a file
	nmap <buffer> ff %:w<CR>:buffer #<CR>
	" rename a file
	nmap <buffer> fe R
	" copy marked files
	nmap <buffer> fP mc
	" copy marked files to current dir
	nmap <buffer> fp mtmc
	" move marked files
	nmap <buffer> fV mm
	" move marked files to current dir
	nmap <buffer> fv mtmm
	" external command on marked files
	nmap <buffer> f; mx
	" display list of marked files
	nmap <buffer> fl :echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>
	" show target dir
	nmap <buffer> fq :echo 'Target:' . netrw#Expose("netrwmftgt")<CR>
	nmap <buffer> fd mtfq
endfunction

augroup netrw_mapping
	autocmd!
	autocmd filetype netrw call NetrwMapping()
augroup END

" close if final buffer is netrw or the quickfix
augroup finalcountdown
	au!
	autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
	nmap - :Lexplore<cr>
augroup END
" 2}}}

" Project navigation {{{2
" set path to all dirs and sub-dirs in current worrking dir
set path+=**
" add a file of an ext to buffer list and list files in current dir
nnoremap <leader>a :argadd <C-r>=fnameescape(expand('%:p:h'))<CR>/*<C-d>
" choose buffer
nnoremap <leader>b :b <C-d>
" file shortcuts
nnoremap <leader>fp :argadd ~/programming/**
nnoremap <leader>fn :argadd ~/notes/**
nnoremap <leader>fh :argadd ~/**

" change *** to **/* automatically
cnoremap <expr> * getcmdline() =~ '.*\*\*$' ? '/*' : '*'
" '%% <Space>' will change to current file+path
cnoreabbrev <expr> %% fnameescape(expand('%:p'))

" Detect .h files as c not cpp
augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END
" 2}}}

" Compile and run in a terminal buffer (single file)
autocmd BufWinEnter *.c nmap <F8> :w \| 15sp \| te gcc % -o %< && ./%< <CR>
autocmd BufWinEnter *.cpp nmap <F8> :w \| 15sp \| te g++ % -o %< && ./%< <CR>
autocmd BufWinEnter *.py nmap <F8> :w \| 15sp \| te python3 %<CR>
autocmd BufWinEnter *.sh nmap <F8> :w \| 15sp \| te /bin/sh %<CR>
" 1}}}

" Statusline (lightline) {{{1
let g:lightline = {
			\ 'colorscheme': 'nord',
			\
			\ 'active': {
			\ 'left': [ [ 'mode', 'paste' ],
			\           [ 'readonly', 'filename', 'modified' ]
			\			],
			\ 'right': [
			\			   [ 'fileformat', 'fileencoding', 'filetype', 'percent', 'lineinfo' ],
			\			   [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]
			\          ]
			\
			\ },
			\
			\ 'component_expand': {
			\  'linter_checking': 'lightline#ale#checking',
			\  'linter_infos': 'lightline#ale#infos',
			\  'linter_warnings': 'lightline#ale#warnings',
			\  'linter_errors': 'lightline#ale#errors',
			\  'linter_ok': 'lightline#ale#ok',
			\ },
			\
			\ 'component_type' :{
			\     'linter_checking': 'right',
			\     'linter_infos': 'right',
			\     'linter_warnings': 'warning',
			\     'linter_errors': 'error',
			\     'linter_ok': 'right',
			\ },
			\
			\
			\ }

" Triangular Separator
\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },

" Escape codes for ALE icons in lightline
let g:lightline#ale#indicator_checking = " "
let g:lightline#ale#indicator_infos = " "
let g:lightline#ale#indicator_warnings = "  "
let g:lightline#ale#indicator_errors = " "
let g:lightline#ale#indicator_ok = " "
" 1}}}

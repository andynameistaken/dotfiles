if !exists('g:vscode')

" ========================================================
" 			PLUGINS 
" ========================================================

" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kassio/neoterm'
" Plug 'scrooloose/NERDTree'
Plug 'francoiscabrol/ranger.vim'
" Plug 'morhetz/gruvbox'
" Plug 'liuchengxu/space-vim-dark'
" Plug 'savq/melange'
" Plug 'tjdevries/colorbuddy.vim'
" Plug 'tjdevries/gruvbuddy.nvim'
" Plug 'lifepillar/vim-gruvbox8'
Plug 'sainnhe/everforest'
Plug 'rainglow/vim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
" Track the engine.
"Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
"Plug 'honza/vim-snippets'
Plug 'ethanholz/nvim-lastplace'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'akinsho/toggleterm.nvim'
" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'
Plug 'romgrk/barbar.nvim'
" produce markdown tables
Plug 'dhruvasagar/vim-table-mode'
" For bash completion
Plug 'neovim/nvim-lspconfig'
" Indent Blank Lines
" Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'gabrielelana/vim-markdown'
" Multi Cursors
Plug 'mg979/vim-visual-multi'
" Preview Markdown with :MarkdownPreview
" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }


" zettelkasten neovim
Plug 'oberblastmeister/neuron.nvim', {'branch': 'unstable'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


" Initialize plugin system
call plug#end()

" ========================================================
" 			APPEARANCE 
" ========================================================

set termguicolors

" colorscheme melange
" lua require('colorbuddy').colorscheme('gruvbuddy')
" colorscheme everforest
"let g:everforest_background = 'hard'

colorscheme earthsong

" AirLine Themes
let g:airline_theme='everforest'
let g:airline_powerline_fonts = 1  

let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_auto_open = 1
let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
" let g:nvim_tree_disable_netrw = 0

" --------------------------------
"   NeoVim Tree.lua
" --------------------------------
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }
" let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile


" ==========================================================
" 			SETs 
" ==========================================================

" use 4 spaces for tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

" column ruler at 100
set ruler
set colorcolumn=120

" Do not highlight all search occurences
set nohls 
" enable mouse, bc I am fitlthy casua I like options
set mouse=a

" set line numbers
set nu

" remove tildes from blank lines
" set fcs=eob:\ 
let &fcs='eob: '

" ==========================================================
" 			REMAPS 
" ==========================================================
" make backspace work like most other programs
set backspace=indent,eol,start 

" do not move cursor to begining after yank
vmap y y`]
" yank without newline (Ctrl + c)
vnoremap <C-c> <Esc>'<0v'>g_y

"

" ==========================================================
" 			PLUGIN OPTIONS 
" ==========================================================

"
" <--------------------------->
"   Tree Lua
" <--------------------------->
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>



" ---------------------------------------
"  	UtilSnips
" ---------------------------------------
"  " Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ---------------------------------------
"  	VimTex	
" -----------------------------------------------------------------------------
"  VIMTEX OPTIONS
"  ----------------------------------------------------------------------------

" All comented out stuff is condensed to those lines sice VimTex 2.6 (skim
"werks without special configs)
let g:vimtex_view_method = has('mac') ? 'skim' : 'zathura'
let g:vimtex_quickfix_open_on_warning = 0
"" if has('unix')
"     if has('mac')
"         let g:vimtex_view_method = "skim"
"         let g:vimtex_view_general_viewer
"                 \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
"         let g:vimtex_view_general_options = '-r @line @pdf @tex'
" 
"         " This adds a callback hook that updates Skim after compilation
"         let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
"         function! UpdateSkim(status)
"             if !a:status | return | endif
" 
"             let l:out = b:vimtex.out()
"             let l:tex = expand('%:p')
"             let l:cmd = [g:vimtex_view_general_viewer, '-r']
"             if !empty(system('pgrep Skim'))
"             call extend(l:cmd, ['-g'])
"             endif
"             if has('nvim')
"             call jobstart(l:cmd + [line('.'), l:out, l:tex])
"             elseif has('job')
"             call job_start(l:cmd + [line('.'), l:out, l:tex])
"             else
"             call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
"             endif
"         endfunction
"     else
"         let g:latex_view_general_viewer = "zathura"
"         let g:vimtex_view_method = "zathura"
"     endif
" elseif has('win32')
" 
" endif
" 
" let g:tex_flavor = "latex"
" let g:vimtex_quickfix_open_on_warning = 0
" let g:vimtex_quickfix_mode = 2
" if has('nvim')
"     let g:vimtex_compiler_progname = 'nvr'
" endif
" 
" " Can hide specifc warning messages from the quickfix window
" " Quickfix with Neovim is broken or something
" " https://github.com/lervag/vimtex/issues/773
" let g:vimtex_quickfix_latexlog = {
"             \ 'default' : 1,
"             \ 'fix_paths' : 0,
"             \ 'general' : 1,
"             \ 'references' : 1,
"             \ 'overfull' : 1,
"             \ 'underfull' : 1,
"             \ 'font' : 1,
"             \ 'packages' : {
"             \   'default' : 1,
"             \   'natbib' : 1,
"             \   'biblatex' : 1,
"             \   'babel' : 1,
"             \   'hyperref' : 1,
"             \   'scrreprt' : 1,
"             \   'fixltx2e' : 1,
"             \   'titlesec' : 1,
"             \ },
"             \}


" -----------------------------------------
"   lastplace (cursor restore)
" -----------------------------------------
lua require'nvim-lastplace'.setup{}

" lua require('colorbuddy').colorscheme('gruvbuddy')
" -----------------------------------------
"   Markmap
" -----------------------------------------
" Create markmap from the whole file
nmap <Leader>m <Plug>(coc-markmap-create)
" Create markmap from the selected lines
vmap <Leader>m <Plug>(coc-markmap-create-v)
set clipboard=unnamedplus
vnoremap <C-S-c> "+y
vnoremap <C-S-v> "+

" Use <cr> to confirm completion COC
inoremap <silent><expr> <S-TAB> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" tab completion snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction




" set
let g:toggleterm_terminal_mapping = '<C-t>'
" or manually...
autocmd TermEnter term://*toggleterm#*
      \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

"------------------------
" barbar
"-----------------------
"" Move to previous/next
nnoremap <silent>    <C-,> :BufferPrevious<CR>
nnoremap <silent>    <C-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <C-s>    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw :BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used

" Markdown Table Mode 
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" ----------------------------------------------
"   vim visual multi
" ----------------------------------------------

let g:VM_maps = {}
let g:VM_maps["Select Cursor Down"] = '<C-S-Down>'      " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<C-S-Up>'        " start selecting up
" Disable fucking comments, I fucking want to comment stuff when I want to,
" dont do anytning without my knowledge
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

endif

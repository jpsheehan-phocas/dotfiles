" Jesse's nvim config

set nocompatible

" Load plugins
call plug#begin(stdpath('data') . '/plugged')

" Auto-completion
Plug 'neoclide/coc.nvim'

" LSP configurations
Plug 'neovim/nvim-lspconfig'

" Git support
Plug 'airblade/vim-gitgutter'

" Gruvbox theme
Plug 'morhetz/gruvbox'

" Support for just about everything
Plug 'sheerun/vim-polyglot'

" Better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

""""" BEGIN LANGUAGE SERVER CONFIGURATION

lua << EOF
require'lspconfig'
EOF

""""" END LANGUAGE SERVER CONFIGURATION

""""" BEGIN GRUVBOX CONFIGURATION

autocmd vimenter * ++nested colorscheme gruvbox

""""" END GRUVBOX CONFIGURATION

""""" BEGIN GITGUTTER CONFIGURATION

" Set the path to the git executable explicitly if using windows
if has('win32')
    let g:gitgutter_git_executable = 'C:\Program Files\Git\bin\git.exe'
endif

""""" END GITGUTTER CONFIGURATION

""""" BEGIN COC CONFIGURATION
" TextEdit might fail if hidden is not set
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Give more space for displaying messages
set cmdheight=2

" Having longer update time (default is 4000 ms) leads to
" noticable delays and poor user experience
set updatetime=300

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Always show the sign column, otherwise it would shift
" the text each time diagnostics appear/become resolved
if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and
" navigate
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify
" coc to format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use :CocDiagnostics to get all diagnostics of current buffer in
" location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetypes
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer
nmap <leader>ac <Plug>(coc-codeaction)

" Apply AutoFix to problem on current line
nmap <leader>qf <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: requires textDocument.documentSymbol from language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" NOTE: requires textDocument/selectionRange support from language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add :Format command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Add :Fold command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add :OR command to organise imports of the current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)vim's native statusline support
" NOTE: please see `:h coc-status` for integrations with external plugins
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j :<C-u>CocNext<cr>
" Do default action for previous item
nnoremap <silent><nowait> <space>k :<C-u>CocPrev<cr>
" Resume latest coc list
nnoremap <silent><nowait> <space>p :<C-u>CocListResume<cr>

""""" END COC CONFIGURATION

""""" BEGIN MY CONFIGURATIONS

" Use system clipboard
set clipboard+=unnamedplus

" Use hybrid line numbers
set number relativenumber

" Toggle absolute line numbers when in insert mode
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup end

"" Indentation settings
" Makefiles should indent with tabs
filetype plugin indent on
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
" Everything else can use spaces plz
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"" Search options
" Enable search highlighting, case-insenstive unless a capital is used
set hlsearch ignorecase smartcase

" Always display the statusbar
set laststatus=2

" Highlight the current line
set cursorline

" Always show the cursor position
set ruler

" Increase the undo limit
set history=1000

" F# LSP
autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

lua << EOF
require'lspconfig'.fsautocomplete.setup{
cmd = {'dotnet', 'C:\tools\fsautocomplete\fsautocomplete.dll', '--background-service-enabled'}
}
EOF




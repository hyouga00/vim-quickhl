"=============================================================================
" File: quickhl.vim
" Author: t9md <taqumd@gmail.com>
" WebPage: http://github.com/t9md/vim-quickhl
" License: BSD
" Version: 0.5
"=============================================================================

" GUARD: {{{
"============================================================
" if exists('g:quickhl_dev')
  " unlet! g:loaded_quickhl
" endif

" if !exists('g:quickhl_debug')
  let g:quickhl_debug = 0
" endif

" if exists('g:loaded_quickhl')
  " finish
" endif
let g:loaded_quickhl = 1

let s:old_cpo = &cpo
set cpo&vim

if !hlexists("QuickhlTag")
  highlight QuickhlTag gui=underline cterm=underline term=underline
endif

if !hlexists("QuickhlCword")
  highlight link QuickhlCword Search
endif
"}}}

" GlobalVar: {{{
if !exists("g:quickhl_manual_colors")
  let g:quickhl_manual_colors = [
        \ "gui=bold ctermfg=16  ctermbg=153 guifg=#ffffff guibg=#0a7383",
        \ "gui=bold ctermfg=7   ctermbg=1   guibg=#a07040 guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=2   guibg=#4070a0 guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=3   guibg=#40a070 guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=4   guibg=#70a040 guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=5   guibg=#0070e0 guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=6   guibg=#007020 guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=21  guibg=#d4a00d guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=22  guibg=#06287e guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=45  guibg=#5b3674 guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=16  guibg=#4c8f2f guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=50  guibg=#1060a0 guifg=#ffffff",
        \ "gui=bold ctermfg=7   ctermbg=56  guibg=#a0b0c0 guifg=black",
        \ ]
endif

let s:default_settings = {
      \ "g:quickhl_manual_enable_at_startup": 0,
      \ "g:quickhl_manual_keywords": [],
      \ "g:quickhl_tag_enable_at_startup": 0,
      \ "g:quickhl_tag_hl_priority": 9,
      \ "g:quickhl_cword_enable_at_startup": 0,
      \ }

function! s:set_default(dict)
  for [var, val] in items(a:dict)
    if !exists(var)
      let {var} = val
    endif
    unlet! var val
  endfor
endfunction

call s:set_default(s:default_settings)

"}}}

" Keymap: {{{
nnoremap <silent> <Plug>(quickhl-manual-toggle) :call quickhl#manual#toggle('n')<CR>
vnoremap <silent> <Plug>(quickhl-manual-toggle) :call quickhl#manual#toggle('v')<CR>
nnoremap <silent> <Plug>(quickhl-manual-reset)  :call quickhl#manual#reset()<CR>
vnoremap <silent> <Plug>(quickhl-manual-reset)  :call quickhl#manual#reset()<CR>

command!                QuickhlManualList       :call quickhl#manual#list()
"command!                QuickhlManualDump       :call quickhl#manual#dump()
command!                QuickhlManualReset      :call quickhl#manual#reset()
command!                QuickhlManualColors     :call quickhl#manual#colors()
command! -bang -nargs=1 QuickhlManualAdd        :call quickhl#manual#add(<q-args>,<bang>0)
command! -bang -nargs=* QuickhlManualDelete     :call quickhl#manual#del(<q-args>,<bang>0)
command!                QuickhlManualLock    :call quickhl#manual#lock()
command!                QuickhlManualUnlock  :call quickhl#manual#unlock()

nnoremap <silent> <Plug>(quickhl-cword-toggle)  :call quickhl#cword#toggle()<CR>
nnoremap <silent> <Plug>(quickhl-cword-enable)  :call quickhl#cword#enable()<CR>
nnoremap <silent> <Plug>(quickhl-cword-disable) :call quickhl#cword#disable()<CR>

command! QuickhlCwordToggle  :call quickhl#cword#toggle()
command! QuickhlCwordEnable  :call quickhl#cword#enable()
command! QuickhlCwordDisable :call quickhl#cword#disable()

nnoremap <silent> <Plug>(quickhl-tag-toggle)     :call quickhl#tag#toggle()<CR>
nnoremap <silent> <Plug>(quickhl-tag-enable)     :call quickhl#tag#enable()<CR>
nnoremap <silent> <Plug>(quickhl-tag-disable)    :call quickhl#tag#disable()<CR>

command! QuickhlTagToggle   :call quickhl#tag#toggle()
command! QuickhlTagEnable   :call quickhl#tag#enable()
command! QuickhlTagDisable  :call quickhl#tag#disable()
"}}}

" AutoCmd: {{{
augroup QuickhlManual
  autocmd!
  autocmd VimEnter,WinEnter * call quickhl#manual#refresh()
  autocmd TabEnter *
        \   if exists(':Tcolorscheme')
        \ |   call quickhl#manual#init_highlight()
        \ | endif
  autocmd! ColorScheme * call quickhl#manual#init_highlight()
augroup END

if g:quickhl_cword_enable_at_startup
  call quickhl#cword#enable()
endif
if g:quickhl_tag_enable_at_startup
  call quickhl#tag#enable()
endif
"}}}

" FINISH: {{{
let &cpo = s:old_cpo
"}}}
" vim: set fdm=marker:

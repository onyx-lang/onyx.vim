" Language: Onyx
" Upstream: https://github.com/onyx-lang/onyx.vim


" Once per buffer
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let s:cpo_orig = &cpo
set cpo&vim

compiler onyx

setlocal expandtab
setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal formatoptions-=t formatoptions+=croql

setlocal suffixesadd=.onyx

if has('comments')
    setlocal comments=://
    setlocal commentstring=//\ %s
endif

let b:undo_ftplugin =
    \ 'setl isk< et< ts< sts< sw< fo< sua< mp< com< cms< inex< inc< pa<'

let &cpo = s:cpo_orig
unlet s:cpo_orig


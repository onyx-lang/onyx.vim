" Adapted from fatih/vim-go: autoload/go/fmt.vim
"
" Copyright 2011 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.

function! onyx#fmt#Check() abort
  " Save cursor position and many other things.
  let view = winsaveview()

  if !executable('onyx')
    echohl Error | echomsg "no onyx binary found in PATH" | echohl None
    return
  endif

  let cmdline = 'onyx check -Dno_entrypoint --no-colors --no-stale-code ' . expand('%:p')

  if exists('*systemlist')
    silent let out = systemlist(cmdline)
  else
    silent let out = split(system(cmdline))
  endif

  let err = v:shell_error

  if err == 0
    " remove undo point caused via BufWritePre.
    try | silent undojoin | catch | endtry

    " No errors detected, close the loclist.
    call setqflist([], 'r')
    cclose
  elseif get(g:, 'onyx_check_parse_errors', 1)
    let errors = s:parse_errors(expand('%:p'), out)

    call setqflist([], 'r', {
        \ 'title': 'Onyx Errors',
        \ 'items': errors,
        \ })

    let max_win_height = get(g:, 'onyx_check_max_window_height', 5)
    " Prevent the loclist from becoming too long.
    let win_height = min([max_win_height, len(errors)])
    " Open the loclist, but only if there's at least one error to show.
    execute 'silent! cwindow ' . win_height
  endif

  call winrestview(view)

  " Run the syntax highlighter on the updated content and recompute the folds if
  " needed.
  syntax sync fromstart
endfunction

" parse_errors parses the given errors and returns a list of parsed errors
function! s:parse_errors(filename, lines) abort
  " list of errors to be put into location list
  let errors = []
  for line in a:lines
    let tokens = matchlist(line, '^(\(.*\):\(\d\+\),\(\d\+\))\s*\(.*\)')
    if !empty(tokens)
      call add(errors,{
            \"filename": tokens[1],
            \"lnum":     tokens[2],
            \"col":      tokens[3],
            \"text":     tokens[4],
            \ })
    endif
  endfor

  return errors
endfunction
" vim: sw=2 ts=2 et

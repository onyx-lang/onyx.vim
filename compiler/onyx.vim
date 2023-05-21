" Vim compiler file
" Compiler:             Onyx Compiler
" Previous Maintainer:  Brendan Hansen <brendan.f.hansen@gmail.com>
" Latest Revision:      2023-05-20
" Upstream:             https://github.com/onyx-lang/onyx.vim

if exists("current_compiler")
  finish
endif
let current_compiler = "onyx"

let s:cpo_save = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=onyx\ check\ %
CompilerSet errorformat=%E\(%f\:%l\\,%c\)\ \%m,%C%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

if exists("b:did_onyx_indent")
  finish
endif
let b:did_onyx_indent = 1

setlocal nosmartindent
setlocal nolisp
setlocal autoindent

setlocal indentexpr=OnyxIndent(v:lnum)

if exists("*OnyxIndent")
  finish
endif

function! OnyxIndent(lnum)
  let prev = prevnonblank(a:lnum-1)

  if prev == 0
    return 0
  endif

  let prevline = getline(prev)
  let line = getline(a:lnum)

  let ind = indent(prev)

  if prevline =~ '[({]\s*$'
    let ind += &sw
  endif

  if line =~ '^\s*[)}]'
    let ind -= &sw
  endif

  return ind
endfunction

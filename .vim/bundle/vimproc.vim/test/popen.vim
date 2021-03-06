let s:suite = themis#suite('parser')
let s:assert = themis#helper('assert')

function! s:suite.popen2()
  if !executable('ls')
    echo 'ls command is not installed.'
    return
  endif

  let cmd = 'ls'
  let sub = vimproc#popen2([cmd])
  let res = ''
  while !sub.stdout.eof
    let res .= sub.stdout.read()
  endwhile
  " Newline conversion.
  let res = substitute(res, '\r\n', '\n', 'g')

  call s:assert.true(sub.is_valid)

  let [cond, status] = sub.waitpid()

  call s:assert.equals(cond, 'exit')

  call s:assert.equals(status, 0)

  call s:assert.false(sub.is_valid)

  call s:assert.equals(res, system(cmd))

  unlet cmd
  unlet sub

  let cmd = ['ls', '-la']
  let sub = vimproc#popen2(cmd)
  let res = ''
  while !sub.stdout.eof
    let res .= sub.stdout.read()
  endwhile
  " Newline conversion.
  let res = substitute(res, '\r\n', '\n', 'g')

  call s:assert.true(sub.is_valid)

  let [cond, status] = sub.waitpid()

  call s:assert.equals(cond, 'exit')

  call s:assert.equals(status, 0)

  call s:assert.false(sub.is_valid)

  call s:assert.equals(res, system(join(cmd)))

  unlet cmd
  unlet sub
endfunction

function! s:suite.popen3()
  let cmd = 'ls'
  let sub = vimproc#popen3([cmd])
  let res = ''
  while !sub.stdout.eof
    let res .= sub.stdout.read()
  endwhile
  " Newline conversion.
  let res = substitute(res, '\r\n', '\n', 'g')

  call s:assert.true(sub.is_valid)

  let [cond, status] = sub.waitpid()

  call s:assert.equals(cond, 'exit')

  call s:assert.equals(status, 0)

  call s:assert.false(sub.is_valid)

  call s:assert.equals(res, system(cmd))

  unlet cmd
  unlet sub
endfunction

function! s:suite.redirection()
  let output = vimproc#system('echo "foo" > test.txt | echo "bar"')
  call s:assert.equals(output, "bar\n")
  call s:assert.equals(readfile('test.txt'), ['foo'])
  if filereadable('test.txt')
    call delete('test.txt')
  endif

  let sub = vimproc#ptyopen('echo "foo" > test.txt | echo "bar"')
  let res = ''
  while !sub.stdout.eof
    let res .= sub.stdout.read()
  endwhile
  " Newline conversion.
  let res = substitute(res, '\r\n', '\n', 'g')
  call s:assert.equals(output, "bar\n")
  call s:assert.equals(readfile('test.txt'), ['foo'])
  if filereadable('test.txt')
    call delete('test.txt')
  endif
endfunction

" vim:foldmethod=marker:fen:

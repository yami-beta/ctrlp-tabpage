if get(g:, 'loaded_autoload_ctrlp_tabpage')
  finish
endif
let g:loaded_autoload_ctrlp_tabpage = 1
let s:save_cpo = &cpo
set cpo&vim

let g:ctrlp_ext_var = add(get(g:, 'ctrlp_ext_vars', []), {
      \ 'init': 'ctrlp#tabpage#init()',
      \ 'accept': 'ctrlp#tabpage#accept',
      \ 'lname': 'tabpage extension',
      \ 'sname': 'tabpage',
      \ 'type': 'path',
      \ 'nolim': 1
      \})
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#tabpage#id() abort
  return s:id
endfunction

function! s:format_tabpagenr(index, tabpagenr) abort
  let winid = win_getid(tabpagewinnr(a:tabpagenr), a:tabpagenr)
  if a:tabpagenr == tabpagenr()
    let winid = win_getid(tabpagewinnr(a:tabpagenr, '#'), a:tabpagenr)
  endif
  let buffer_info = getbufinfo(getwininfo(winid)[0].bufnr)[0]
  let filepath = fnamemodify(buffer_info.name, ':.')
  if filepath == ''
    let filepath = '[No Name]'
  endif
  let separator = repeat(' ', 4 - len(string(a:tabpagenr)))
  return a:tabpagenr . separator . filepath
endfunction

function! ctrlp#tabpage#init(...) abort
  let tabpage_list = map(range(1, tabpagenr('$')), function('<SID>format_tabpagenr'))
  return tabpage_list
endfunction

function! ctrlp#tabpage#accept(mode, str) abort
  call ctrlp#exit()
  let tabpagenr = matchstr(a:str, '^\d\+')
  execute 'tabnext ' . tabpagenr
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

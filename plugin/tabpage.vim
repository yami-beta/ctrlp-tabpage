if get(g:, 'loaded_ctrlp_tabpage')
  finish
endif
let g:loaded_ctrlp_tabpage = 1
let s:save_cpo = &cpo
set cpo&vim

command! CtrlPTabpage call ctrlp#init(ctrlp#tabpage#id())

let &cpo = s:save_cpo
unlet s:save_cpo

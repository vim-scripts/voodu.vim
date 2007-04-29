" Learning Voodu (Vim Object-Orientation Definition Utilities)
" Ian A. Tegebo <ian.tegebo@gmail.com>
let s:_CLASS_ = expand('<sfile>')

function! tv#New(type)"Constructor
	let l:self = {}
	call extend(l:self, { 'TYPE': a:type})
	call Bless(l:self,s:_CLASS_)
	return l:self
endfunction

"function! tv#Name() dict"name
"	return self.NAME
"endfunction

func! tv#Type() dict"type
	return self.TYPE
endfunc

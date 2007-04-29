" An example of subclassing the 'series' subClass.
let s:_CLASS_ = expand('<sfile>')

func! tv#series#comedy#New(name)"Constructor
	let l:self = tv#series#New(a:name,'Comedy')
	call Bless(l:self,s:_CLASS_)
	return l:self
endfunc

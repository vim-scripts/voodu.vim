" An example of subclassing the 'tv' Class.
let s:_CLASS_ = expand('<sfile>')

" Some Class Data
let s:SERIES = {}

func! tv#series#New(name,type)"Constructor
	let l:self = tv#New(a:type)
	call extend(l:self, { 'NAME': a:name})
	call Bless(l:self,s:_CLASS_)

	" First example of using class data.
	" 	I really just want a list of the names of each series that gets
	" 	created but don't want to have to search it for duplicates.  I was
	" 	using s:SERIES as a list before with add() but in testing I wound up
	" 	duplicating my series' names each time I sourced my driver script.
	call extend(s:SERIES, { l:self.name(): 1 })

	return l:self
endfunc

func! tv#series#Name() dict"name
	return self.NAME
endfunc

func! tv#series#Names()"ClassFunc
	return keys(s:SERIES)
endfunc

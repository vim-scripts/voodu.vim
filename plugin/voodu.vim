" Vim global plugin for implementing Vim OOP 
" Last Change:	2007 Apr 29
" Version:		0.0.1
" Maintainer:	Ian Tegebo <ian.tegebo@gmail.com>
" License:	This file is placed in the public domain.

" 	TODO: Make linenr and filename function-local.
"
" Build RegEx that captures both the internal function name and method name
" defined after comments.
let s:fdef_rx = '^fu\%[nction]!\?'
let s:fname_rx = '\%(s:\)\?[_#[:alnum:]]\+'
let s:fargs_rx = '([^)]*)'

"------------------ ------------Build up final RegEx -------------------------
let s:funcdef_rx = s:fdef_rx " Function command definition
let s:funcdef_rx .= '\s\+'
let s:funcdef_rx .= '\('.s:fname_rx.'\)' " Match the function name
let s:funcdef_rx .= s:fargs_rx 
let s:funcdef_rx .= '[^"]*\"\s*' " non-comment char, \", then whitespace
let s:funcdef_rx .= '\(\w\+\)'

let s:classcntrl_rx = 'Constructor\|ClassFunc'

" This function is really internal to the s:GetMethods function.
func! s:GetFuncMethPair(line)
	" We expect a line that looks something like:
	" 	function MyInternFunc()	" externfunc
	try
		let l:fpair = matchlist(a:line, s:funcdef_rx)
		call filter(l:fpair, 'v:val != ""')
		throw len(l:fpair)
	catch /3/				" Recall matchlist returns match+submatches
		return l:fpair[1:2]
	catch /[0-24-9]\+/
		" Perhaps I could add an internal debugging flag to get at things like
		" v:exception and v:throwpoint.
		echoerr "Incorrect function line in ".s:filename." at ".s:linenr
		return 1
	endtry
endfunc

func! s:GetMethods(class)
	let s:filename = a:class

	let s:linenr = 0	" Keep track of line number for error reporting
	let l:FuncMethDict = {}

	" Run over whole file and create dictionary of FuncMeth pairs.
	for l:line in readfile(s:filename)
		let s:linenr += 1		" Keep track for reporting errors to user.
		if l:line =~ '^fu'
			let l:pair = s:GetFuncMethPair(l:line)
			" Ignore Class Functions and Constructors
			if l:pair[1] !~ s:classcntrl_rx
				let l:FuncMethDict[l:pair[1]] = function(l:pair[0])
			endif
		endif
	endfor

	return l:FuncMethDict

endfunc

function! Bless(obj,class)
	let l:ClassMethods = s:GetMethods(a:class)
	" I should throw and catch errors with when this overwrites key/values.
	" 	Ideally the exceptions would tell the user what ClassMethods were
	" 	trying to overwrite what other keys.
	call extend(a:obj, l:ClassMethods, "error")
endfunction

finish

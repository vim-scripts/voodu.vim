" An example plugin for using Voodu
" Ian A. Tegebo <ian.tegebo@gmail.com>
" Mon Apr 16 01:19:35 PDT 2007

let s:AD = tv#series#comedy#New('Arrested Development')
let s:TO = tv#series#comedy#New('The Office')

echo s:AD.name()
" Testing inheritance
echo s:AD.type()
echo s:TO.name()." is a ".s:TO.type()

let s:SS = tv#series#comedy#New('The Simpsons') 

echo tv#series#Names()

let s:dailyshow = tv#New('News Parody')
echo s:dailyshow.type()

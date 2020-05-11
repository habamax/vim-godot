" Vim syntax file for Godot gdscript
" Language:     gdscript
" Maintainer:   Maxim Kim <habamax@gmail.com>
" Filenames:    *.gd

if exists("b:current_syntax")
	finish
endif

syn keyword gdscriptConditional if else elif match switch case is as not and or
syn keyword gdscriptRepeat for while break continue in
syn keyword gdscriptConstant PI TAU INF NAN
syn keyword gdscriptType void bool int float

syn match gdscriptFunctionCall "\v<\w*>\s*(\()@="

syn keyword gdscriptBuiltinFunction sin cos tan sinh cosh tanh asin acos atan atan2
syn keyword gdscriptBuiltinFunction sqrt fmod fposmod
syn keyword gdscriptBuiltinFunction floor ceil round
syn keyword gdscriptBuiltinFunction abs sign pow log exp is_nan is_inf
syn keyword gdscriptBuiltinFunction ease decimals stepify lerp dectime
syn keyword gdscriptBuiltinFunction randomize randi randf rand_range seed rand_seed
syn keyword gdscriptBuiltinFunction deg2rad rad2deg linear2db db2linear
syn keyword gdscriptBuiltinFunction max min clamp len
syn keyword gdscriptBuiltinFunction nearest_po2 weakref funcref convert typeof type_exists
syn keyword gdscriptBuiltinFunction char str var2str str2var var2bytes bytes2var
syn keyword gdscriptBuiltinFunction print prints printt printerr printraw print_stack
syn keyword gdscriptBuiltinFunction range load inst2dict dict2inst hash instance_from_id
syn keyword gdscriptBuiltinFunction parse_json to_json
syn keyword gdscriptBuiltinFunction str int
syn keyword gdscriptBuiltinFunction preload yield

syn keyword gdscriptBuiltinClass Input InputEventAction
syn keyword gdscriptBuiltinClass OS
syn keyword gdscriptBuiltinClass Tween Sprite Texture Node Color
syn keyword gdscriptBuiltinStruct Color

syn keyword gdscriptKeyword false null true self 

syn keyword gdscriptStatement class_name nextgroup=gdscriptClass skipwhite
syn keyword gdscriptStatement class func nextgroup=gdscriptFunction skipwhite
syn keyword gdscriptStatement extends nextgroup=gdscriptExtend skipwhite
syn keyword gdscriptStatement remote master puppet remotesync mastersync puppetsync sync
syn keyword gdscriptStatement setget return pass
syn keyword gdscriptStatement static const enum var signal
syn keyword gdscriptStatement breakpoint assert
syn keyword gdscriptStatement onready export

syn match gdscriptFunction "\h\w*" display contained
syn match gdscriptExtend "\h\w*" display contained
syn match gdscriptClass "\h\w*" display contained

syn match gdscriptNode "\$\h\w*\%(/\h\w*\)*"

syn match gdscriptSpecial "[():]"

syn match gdscriptComment "#.*$" contains=@Spell

syn region gdscriptString matchgroup=gdscriptQuotes
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=pythonEscape,@Spell

syn region gdscriptString matchgroup=gdscriptTripleQuotes
      \ start=+[uU]\=\z('''\|"""\)+ end="\z1" keepend
      \ contains=pythonEscape,@Spell

syn match gdscriptEscape +\\[abfnrtv'"\\]+ contained
syn match gdscriptEscape "\\$"

" Numbers
syn match gdscriptNumber "\<0[oO]\=\o\+[Ll]\=\>"
syn match gdscriptNumber "\<0[xX]\x\+[Ll]\=\>"
syn match gdscriptNumber "\<0[bB][01]\+[Ll]\=\>"
syn match gdscriptNumber "\<\%([1-9]\d*\|0\)[Ll]\=\>"
syn match gdscriptNumber "\<\d\+[jJ]\>"
syn match gdscriptNumber "\<\d\+[eE][+-]\=\d\+[jJ]\=\>"
syn match gdscriptNumber
\ "\<\d\+\.\%([eE][+-]\=\d\+\)\=[jJ]\=\%(\W\|$\)\@="
syn match   gdscriptNumber
\ "\%(^\|\W\)\zs\d*\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>"


hi def link gdscriptStatement Statement
hi def link gdscriptKeyword Keyword
hi def link gdscriptConditional Conditional
hi def link gdscriptRepeat Repeat
hi def link gdscriptConstant Constant
hi def link gdscriptFunction Function
hi def link gdscriptExtend Define
hi def link gdscriptClass Define
hi def link gdscriptBuiltinFunction Function
hi def link gdscriptFunctionCall Function
hi def link gdscriptBuiltinClass Define
hi def link gdscriptBuiltinStruct Typedef
hi def link gdscriptComment Comment
hi def link gdscriptString String
hi def link gdscriptQuotes String
hi def link gdscriptTripleQuotes String
hi def link gdscriptEscape Special
hi link gdscriptNode PreProc
hi def link gdscriptType Type
hi def link gdscriptNumber Number
hi def link gdscriptSpecial Special



let b:current_syntax = "gdscript"

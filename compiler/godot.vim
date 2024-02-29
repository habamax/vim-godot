" Compiler:	godot

if exists("current_compiler")
  finish
endif
let current_compiler = "godot"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet errorformat=

" Ignore cpp lines.
CompilerSet errorformat+=%-G%\\s%#at:%.%#\ \(%.%#.cpp:%\\d%\\+)

" Match filenames including res:// which works because of godot#edit_res_path.

" Use each file and line of backtraces (to see and step through the code executing).
"  GDScript backtrace (most recent call first):
"      [0] save_children_states (res://room/room_data.gd:128)
"      [1] store_states (res://interfaces/i_room.gd:341)
CompilerSet errorformat+=%*[\ \t][%*[0-9]]\ %m\ (%f:%l)

CompilerSet errorformat+=%tRROR:\ Failed\ to\ load\ script\ \"%f\"\ with\ error\ \"%m\".
CompilerSet errorformat+=%tRROR:\ %.%#\\,\ script\ \'%f\'%m

" These parse errors have the file on another line.
CompilerSet errorformat+=%ESCRIPT\ ERROR:\ %m
CompilerSet errorformat+=%-C%\\s%#at:\ %s\ (%f:%l)

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2:


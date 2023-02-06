" Vim filetype plugin file
" Language: Godot shading language
" Maintainer: Shatur95 <genaloner@gmail.com>, Maxim Kim <habamax@gmail.com>

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
let s:keepcpo = &cpo
set cpo&vim

let b:undo_ftplugin = 'setlocal suffixesadd<'
      \ . '|setlocal noexpandtab<'

setlocal suffixesadd=.shader,.gdshader,.gdshaderinc
setlocal noexpandtab

command! -buffer -nargs=? -complete=customlist,godot#scene_complete GodotRun call godot#run(<q-args>)
command! -buffer GodotRunFZF call godot#fzf_run_scene()

let &cpo = s:keepcpo
unlet s:keepcpo

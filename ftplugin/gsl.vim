" Vim filetype plugin file
" Language: Godot shading language
" Maintainer: Maxim Kim <habamax@gmail.com>

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
let s:keepcpo = &cpo
set cpo&vim

let b:undo_ftplugin = '|setlocal suffixesadd<'
      \ . '|setlocal noexpandtab<'

setlocal suffixesadd=.shader
setlocal noexpandtab

if !exists("g:godot_executable")
    if executable('godot')
        let g:godot_executable = 'godot'
    elseif executable('godot.exe')
        let g:godot_executable = 'godot.exe'
    endif
endif

command! -buffer -nargs=? -complete=customlist,godot#scene_complete GodotRun call godot#run(<q-args>)
command! -buffer GodotRunFZF call godot#fzf_run_scene()

let &cpo = s:keepcpo
unlet s:keepcpo

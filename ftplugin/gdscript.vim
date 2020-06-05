" Vim filetype plugin file
" Language: gdscript (Godot game engine)
" Maintainer: Maxim Kim <habamax@gmail.com>

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1
let s:keepcpo = &cpo
set cpo&vim

let b:undo_ftplugin = 'setlocal cinkeys<'
      \ . '|setlocal indentkeys<'
      \ . '|setlocal commentstring<'
      \ . '|setlocal suffixesadd<'
      \ . '|setlocal expandtab<'
      \ . '|setlocal foldexpr<'
      \ . '|setlocal foldignore<'

setlocal cinkeys-=0#
setlocal indentkeys-=0#
setlocal suffixesadd=.gd
setlocal commentstring=#\ %s
setlocal foldignore=
setlocal foldexpr=GDScriptFoldLevel()

func! GDScriptFoldLevel() abort
    let line = getline(v:lnum)
    if line =~? '^\s*$'
        return -1
    endif

    let sw = shiftwidth()
    let indent = indent(v:lnum) / sw
    let indent_next = indent(nextnonblank(v:lnum+1)) / sw

    if indent_next > indent && line =~ ':\s*$'
        return ">" . indent_next
    else
        return indent
    endif

endfunc

if !exists("g:godot_executable")
    if executable('godot')
        let g:godot_executable = 'godot'
    elseif executable('godot.exe')
        let g:godot_executable = 'godot.exe'
    endif
endif


command! -buffer GodotRunCurrent call godot#run_current()
command! -buffer GodotRunLast call godot#run_last()
command! -buffer -nargs=? -complete=customlist,godot#scene_complete GodotRun call godot#run(<q-args>)
command! -buffer GodotRunFZF call godot#fzf_run_scene()

let &cpo = s:keepcpo
unlet s:keepcpo

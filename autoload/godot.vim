let s:last_scene_run = ''

" Run last scene
func! godot#run_last() abort
    if s:last_scene_run == ''
        echom "No scene was run yet!"
        return
    endif
    call s:run_scene(s:last_scene_run)
endfunc


" Run current scene
func! godot#run_current() abort
    let scene_name = s:find_scene_name()
    call s:run_scene(scene_name)
endfunc


" Run scene
func! godot#run(...) abort
    let cwd = getcwd()
    try
        exe 'lcd ' . s:project_path()
        if a:0 && !empty(a:1)
            if a:1 =~ '\.tscn$'
                call s:run_scene(a:1)
            else
                call s:run_scene(a:1 . '.tscn')
            endif
        else
            call s:run_scene(s:find_main_scene())
        endif
    finally
        exe 'lcd ' . cwd
    endtry
endfunc


" Run arbitrary scene
func! s:run_scene(scene_name) abort
    let s:last_scene_run = a:scene_name
    " if there is vim-dispatch installed, use it
    " vim-dispatch can't Start application in windows neovim :(
    " https://github.com/tpope/vim-dispatch/issues/297
    if has('win32') && has('nvim')
        let cmd = "!start "
    elseif exists("$WSLENV") && !exists("$TMUX")
        let cmd = "!cmd.exe /c start "
    elseif exists(":Spawn")
        let cmd = "Spawn "
    elseif executable("cmd.exe")
        let cmd = "!cmd.exe /c start "
    elseif has("mac") " XXX: need test
        let cmd = "!open "
    elseif has("unix") " XXX: need test
        let cmd = "!xdg-open "
    else
        let cmd = "!"
    endif
    exe printf("%s%s %s",
                \ cmd,
                \ get(g:, "godot_executable", "godot"),
                \ fnameescape(a:scene_name))
endfunc


" Look for project.godot file and extract main_scene
" If it is not there, return current scene name
func! s:find_main_scene() abort
    let project_file = findfile("project.godot", ".;")

    for line in readfile(project_file)
        if line =~ "^run/main_scene="
            return matchstr(line, 'res://\zs.*\ze"')
        endif
    endfor

    return s:find_scene_name()
endfunc


" Return project path
func! s:project_path() abort
    return fnamemodify(findfile("project.godot", ".;"), ":h")
endfunc


" Assuming:
" * Scene base name is the same as script base name;
" * Both are in the same directory.
"
" This has to be enhanced in the future (read all *.tscn files and check if
" script name == to current file?
func! s:find_scene_name() abort
    return expand("%:r").".tscn"
endfunc


" Basic completion for godot scene selection :GodotRun <tab>
func! godot#scene_complete(A, L, P) abort
    return split(globpath(s:project_path(), '**/*' . a:A . '*.tscn'), "\n")
endfunc


" FZF completion for godot scene selection :GodotRunFZF<CR>
func! godot#fzf_run_scene(...)
    if !exists('*fzf#run') || !executable('fzf')
        echom "fzf is not installed!"
        return
    endif

    let project_path = s:project_path()

    if executable('fdfind')
        let scenes = 'fdfind -e tscn --type f --hidden --follow --no-ignore-vcs --exclude .git'
    elseif executable('fd')
        let scenes = 'fd -e tscn --type f --hidden --follow --no-ignore-vcs --exclude .git'
    elseif executable('rg')
        let scenes ='rg -g *.tscn --files --no-ignore-vcs '
    else
        let scenes = split(globpath(project_path, "**/*.tscn"), "\n")
    endif

    return fzf#run(fzf#wrap('scenes', {
                \ 'source':  scenes,
                \ 'sink':    'GodotRun',
                \ 'dir':    project_path,
                \ 'options': '+m --prompt="Scenes> "'
                \}, 0))

endfunc

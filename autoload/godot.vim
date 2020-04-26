" Run current scene: 
func! godot#run_current_scene() abort
    let scene_name = s:find_scene_name()
    call s:run_scene(scene_name)
endfunc


" Run main scene
func! godot#run_main_scene() abort
    let main_scene = s:find_main_scene()
    call s:run_scene(main_scene)
endfunc



func! s:run_scene(scene_name) abort
    exe printf("Start %s %s",
                \ get(g:, "godot_executable", "godot"),
                \ a:scene_name)
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


" Assuming:
" * Scene base name is the same as script base name;
" * Both are in the same directory.
"
" This has to be enhanced in the future (read all *.tscn files and check if
" script name == to current file?
func! s:find_scene_name() abort
    return expand("%:r").".tscn"
endfunc

augroup godot
    au! *
    autocmd BufReadCmd res://* call godot#edit_res_path(expand("<amatch>"))
augroup END

augroup godot
    au! *
    autocmd BufReadCmd res://* ++nested call godot#edit_res_path(expand("<amatch>"))
augroup END

" Auto-source $HOME/.vimrc or $XDG_CONFIG_HOME/nvim/init.vim on write.
augroup SourceGrp
    autocmd!
    autocmd BufWritePost $MYVIMRC let s:source_output = [] |
\        try | 
\            set shortmess+=c | 
\            source % |
\            set shortmess-=c | 
\            redraw |
\        catch /^Vim%((\a\+)\)\=:E\(.\+\):/ | 
\            let s:source_output = [] | 
\            let s:save_efm = &efm | 
\            set efm=%f | 
\            let s:source_output = [] | 
\            for line in readfile($MYVIMRC) | 
\                call execute(line) | 
\            endfor | 
\            let &efm = s:save_efm | 
\            echom 'Error: ' . substitute(submatch(1), '^.*:s*', '', '') | 
\            echom 'Press ENTER or type command to continue (SourceGrp)' | 
\            silent! call input('') | 
\        endtry | 
\        echom 'Warning: Reloaded ' . $MYVIMRC . '!!' | 
\        if !empty(s:source_output) | 
\            echom join(s:source_output, "n") | endif
augroup END

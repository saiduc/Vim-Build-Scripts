" C++
autocmd FileType cpp noremap <silent> <C-b> :call SaveBuildAndExecuteCPP()<CR>
autocmd FileType cpp vnoremap <silent> <C-b> :<C-u>call SaveBuildAndExecuteCPP()<CR>

function! SaveBuildAndExecuteCPP()

    " Save the window where you are currently
    let l:currentWindow=winnr()

    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " build current file
    silent execute "!g++ % -o tmpbuild"

    let s:output_buffer_name = "CPP"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""
    setlocal laststatus=0 " turns off lightline for buffer
    setlocal cc=0 " disables ruler for buffer
    resize 10

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    execute ".!./" . shellescape("tmpbuild", 1) 

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
    :$
    
    " Delete tmpbuild file
    silent execute "!rm tmpbuild"
    
    
    " Go back to the original window
    exe l:currentWindow . "wincmd w"

endfunction

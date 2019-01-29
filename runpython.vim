"  Python 3:
autocmd FileType python noremap <silent> <C-b> :call SaveAndExecutePython3()<CR>
autocmd FileType python vnoremap <silent> <C-b> :<C-u>call SaveAndExecutePython3()<CR>

function! SaveAndExecutePython3()

    " Save the window where you are currently
    let l:currentWindow=winnr()

    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python 3"
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
    silent execute ".!python3 " . shellescape(s:current_buffer_file_path, 1)

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
    :$
	
    " Go back to the original window
    exe l:currentWindow . "wincmd w"

endfunction


" Python 2
autocmd FileType python noremap <silent> <C-d> :call SaveAndExecutePython2()<CR>
autocmd FileType python vnoremap <silent> <C-d> :<C-u>call SaveAndExecutePython2()<CR>

function! SaveAndExecutePython2()

    " Save the window where you are currently
    let l:currentWindow=winnr()

    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python 2"
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
    silent execute ".!python " . shellescape(s:current_buffer_file_path, 1)

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
    :$
	
    " Go back to the original window
    exe l:currentWindow . "wincmd w"

endfunction

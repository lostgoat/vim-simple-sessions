"
" simple-sessions.vim: simple mechanism for session management
"
" Modified by: Andres Rodriguez

if !exists('g:simple_session_autosave')
    let g:simple_session_autosave = 0
endif

if !exists('g:simple_session_dir')
    let g:simple_session_dir = $HOME . "/.vim/simple-sessions"
endif

" Don't save options to the session, it will mess vimrc loading
" in the future
set sessionoptions-=options
set sessionoptions-=blank

function! GetSessionName()
    " No session will be used if vim was invoked with arguments
    if argc() != 0
        return ""
    end

    " Otherwise use the current directory as a name
    let l:name = substitute(getcwd(), "/", "_", "g")
    return l:name
endfunction

let s:session_name = GetSessionName()
let s:session_file = g:simple_session_dir . "/" . s:session_name . ".vim"

" Create the session directory if it doesn't exist
if !isdirectory(g:simple_session_dir)
    call mkdir(g:simple_session_dir, 'p')
endif

let s:session_restored = 0

" Restore the current identified session
function! RestoreSession()
    if s:session_name == ""
        return
    endif
    
    if filereadable(s:session_file)
        execute 'source ' . s:session_file
    end

    let s:session_restored = 1
endfunction

" Save the currently identified session
function! SaveSession()
    if s:session_name == ""
        return
    endif

    " Don't clobber the saved session until it is loaded
    if s:session_restored == 0
        return
    endif

    execute 'mksession! ' . s:session_file
endfunction

" Restore and save sessions.
augroup SimpleSessions
    autocmd!
    if argc() == 0
        autocmd VimEnter * nested call RestoreSession()
        if g:simple_session_autosave == 1
            autocmd VimLeavePre * call SaveSession()
            autocmd BufEnter * call SaveSession()
        end
    end
augroup END

command! SaveSession :call SaveSession()
command! RestoreSession :call RestoreSession()

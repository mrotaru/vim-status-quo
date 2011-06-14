" --------------------------------------------------------------------
" File: status-quo.vim
" Author: Mihai Rotaru ( mihai_rotaru@lavabit.com )
" Purpose: add an enhanced status bar to vim
" Features: concise, versatile, color-scheme aware.
" --------------------------------------------------------------------

set statusline=
            \%#PmenuSel#%f\ 
            \%{Get_RO_Char()}\ 
            \%#FoldColumn#%2n\ 
            \%#PmenuSel#\ \
            \%#PmenuThumb#%4l\
            \/\ %-4L%*
            \%2c\
            \%#PmenuSel#\ 
            \hl:\ %{StatusLineRealSyn()}\ 
            \%=%{strftime(\"%H:%M\")}

fun! StatusLineRealSyn()
    let synId = synID(line('.'),col('.'),1)
    let realSynId = synIDtrans(synId)
    if synId == realSynId
        return 'Normal'
    else
        return synIDattr( realSynId, 'name' )
    endif
endfunction

function! Get_RO_Char()
    if &readonly
        return "r"
    else
        return ""
    endif
endfunction

let g:active_statusline=&g:statusline
let g:inactive_statusline=substitute( g:active_statusline, 'PmenuSel', 'PmenuSbar', 'g' )

au WinEnter * let&l:statusline = g:active_statusline
au WinLeave * let&l:statusline = g:inactive_statusline

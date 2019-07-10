" add .sql when typing gf (go to file under cursor)
au BufNewFile,BufRead *.sql set ft=dbt suffixesadd+=.sql
au BufNewFile,BufRead *.md set suffixesadd+=.sql
au BufNewFile,BufRead *.yml set suffixesadd+=.sql

" make sure you update the paths with the location of dbt in your environment!
" update path to look for files in dbt directories
au BufNewFile,BufRead *.sql set path+=[put path to where dbt lives here]/dbt/macros/**
au BufNewFile,BufRead *.sql set path+=[put path to where dbt lives here]/dbt/models/**

" yml and md are for opening files from dbt docs files
au BufNewFile,BufRead *.yml set path+=[put path to where dbt lives here]/dbt/macros/**
au BufNewFile,BufRead *.yml set path+=[put path to where dbt lives here]/dbt/models/**

au BufNewFile,BufRead *.md set path+=[put path to where dbt lives here]/dbt/macros/**
au BufNewFile,BufRead *.md set path+=[put path to where dbt lives here]/dbt/models/**

" remove syntax highlighting and set files to not modifiable for compile dbt sql
au BufNewFile,BufRead */target/*.sql set noma ft=text

" send the output of a command to a new buffer
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize '
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

nnoremap <leader>got :execute 'Shell dbt-helper open <c-r><c-w> --print'<CR>
nnoremap <leader>gof :execute 'Shell dbt-helper open '.substitute(expand('%:t'),'\..*$','',"g").' --print'<CR>

source $HOME/.vim/config/dbtrpc.vimrc

" add .sql when typing gf (go to file under cursor)
au BufNewFile,BufRead *.sql set ft=dbt suffixesadd+=.sql
au BufNewFile,BufRead *.md set suffixesadd+=.sql
au BufNewFile,BufRead *.yml set suffixesadd+=.sql

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

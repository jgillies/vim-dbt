# vim-dbt
Utilities to make it more pleasant to work on the already pleasant [dbt](https://www.getdbt.com/) in Vim

* `dbt.snippets` works with [UltiSnips](https://github.com/sirver/UltiSnips) to provide snippets for common dbt functionality (ported from [atom-dbt](https://github.com/fishtown-analytics/atom-dbt))
* `dbt.vimrc` makes Vim's `gf` command work to open a model when its name is under the cursor
  * Make sure to edit to update paths to reflect your dbt environment
  * Put this in `~/.vim/config/`, then add `source $HOME/.vim/config/dbt.vimrc` to your `.vimrc` file
  * Should work in model and documentation files

python3 << en

import json
import base64

import requests
import uuid

import vim


def submitRpc():
    url = "http://0.0.0.0:8580/jsonrpc"
    headers = {'content-type': 'application/json'}
    cb = '\n'.join(vim.current.buffer)
    sql = cb.encode('ascii')
    encoded_sql = base64.b64encode(sql).decode('utf-8')
    filepath = vim.current.buffer.name
    filename = os.path.splitext(os.path.basename(filepath))[0]
    payload = {
            "jsonrpc": "2.0",
            "method": "compile",
            "id": uuid.uuid1().int,
            "params": {
                "timeout": 60,
                "sql": encoded_sql,
                "name": filename
                }
            }

    response = requests.post(
        url, data=json.dumps(payload), headers=headers
            ).json()

    compiled_sql = response['result']['compiled_sql']

    print(compiled_sql)
en

function! Redir(cmd)
	for win in range(1, winnr('$'))
		if getwinvar(win, 'scratch')
			execute win . 'windo close'
		endif
	endfor
	if a:cmd =~ '^!'
		let output = system(matchstr(a:cmd, '^!\zs.*'))
	else
		redir => output
		execute a:cmd
		redir END
	endif
	vnew
	let w:scratch = 1
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, split(output, "\n"))
endfunction

command! -nargs=1 -complete=command Redir silent call Redir(<q-args>)

nmap <leader>rpcc :Redir python3 submitRpc()<CR>

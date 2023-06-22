```shell-session
$ ruby -I./lib -rio/pipe -e 'using IO::Pipe' -e 'p *`cp`.redirect(err: %i[child out])'
"cp: missing file operand\n"
"Try 'cp --help' for more information.\n"
```

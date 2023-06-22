```shell-session
$ ruby -I./lib -rio/pipe -e 'using IO::Pipe' -e 'p *`cp`.redirect(err: %i[child out])'
"cp: missing file operand\n"
"Try 'cp --help' for more information.\n"
```

```shell-session
$ ruby -I./lib -rio/pipe -e 'using IO::Pipe' -e 'p *`ls *.md`.each(chomp: true)'
"README.md"
```

```shell-session
$ ruby -I./lib -rio/pipe -e 'using IO::Pipe' -e 'p *`git ls-files -z *.md`.each("\0", chomp: true)'
"LICENSE.md"
"README.md"
```

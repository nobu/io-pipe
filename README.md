# IO::Pipe

This library provides extended `` Kernel#` ``.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add io-pipe

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install io-pipe

## Usage

With redirection.

```shell-session
$ ruby -I./lib -rio/pipe -e 'using IO::Pipe' -e 'p *`cp`.redirect(err: %i[child out])'
"cp: missing file operand\n"
"Try 'cp --help' for more information.\n"
```

With chomping.

```shell-session
$ ruby -I./lib -rio/pipe -e 'using IO::Pipe' -e 'p *`ls *.md`.each(chomp: true)'
"README.md"
```

With different line separator and chomping.

```shell-session
$ ruby -I./lib -rio/pipe -e 'using IO::Pipe' -e 'p *`git ls-files -z *.md`.each("\0", chomp: true)'
"LICENSE.md"
"README.md"
```

## Development

After checking out the repo, run `bundle install` to install
dependencies

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nobu/io-pipe.

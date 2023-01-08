# Issues

A simple CLI to fetch GitHub issues

(This is practice code in "Programming Elixir" chapter 13)

## Usage

```
# build
$ mix deps
$ mix deps.get
$ mix escript.build

# help
$ ./issues -h
usage: issues <user> <project> [ count | 4 ]

# fetch the latest 5 issues in elixir-lang/elixir
$ ./issues elixir-lang elixir 5
#     | created_at           | title
------+----------------------+----------------------------------------------
12301 | 2022-12-15T16:00:58Z | Let `pid/1` parse a pid's inspection string
12312 | 2022-12-25T16:50:37Z | Cache body of defmodule when possible
12315 | 2022-12-27T04:23:24Z | Add ability for System.cmd/3 to return lines
12318 | 2023-01-05T22:17:27Z | Weird App Dependency Errors in Umbrella
12320 | 2023-01-06T01:00:48Z | Makefile has race conditions (exposed by -j4)
```


## For developers

```bash
# run tests
$ mix test
# generate docs in ./doc
$ mix doc
```

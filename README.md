# bash-env-fish

- import Bash environment into Fish shell
- extract Bash style shell variables from source files like `/etc/os-release`

## Installation

May be installed from this repo using [Fisher](https://github.com/jorgebucaran/fisher).

### Dependencies

The heavy lifting is done by [bash-env-json](https://github.com/tesujimath/bash-env-json) which must be separately installed and added to the path.

## Example Usage

```
> echo 'export A=1; export B=2; export Z=101' | bash-env
> echo $A $B $Z
1 2 101

> cat abc.env
export A=101
export B=102
export C="fooled ya!"

> bash-env abc.env
> echo $A $B $C
101 102 fooled ya!

> ssh-agent | bash-env
Agent pid 921717
> echo $SSH_AUTH_SOCK
/tmp/ssh-XXXXXXI4IoXr/agent.921715

> bash-env /etc/os-release
> echo $PRETTY_NAME
NixOS 24.11 (Vicuna)
> fish
Welcome to fish, the friendly interactive shell
Type help for instructions on how to use fish
> echo $PRETTY_NAME
<no output>
```

## History

This approach for Bash environment support for non-POSIX shells was pioneered in [bash-env-nushell](https://github.com/tesujimath/bash-env-nushell) for [Nushell](https://www.nushell.sh/).  The Bash backend was extracted as the common dependency [bash-env-json](https://github.com/tesujimath/bash-env-json) when adding similar support in [bash-env-elvish](https://github.com/tesujimath/bash-env-elvish) for [Elvish](https://elv.sh/).  And now for Fish.

## Alternatives

- [Bass](https://github.com/edc/bass)

## See also

- [lmod-fish](https://github.com/tesujimath/lmod-fish)

function bash-env
    # alas this pollutes the environment
    function __bash-env-from-json
        jq -r '
            (.env // {} | to_entries[]
                | if .value == null
                  then "set -e \\(.key);"
                  else "set -gx \\(.key) \\(.value | @sh);"
                  end),
            (.shellvars // {} | to_entries[]
                | "set -g \\(.key) \\(.value | @sh);")
            '
    end

    if test (count $argv) -gt 0
        eval (bash-env-json $argv | __bash-env-from-json)
    else
        # capture stdin into a temporary file and pass that to bash-env-json
        set -l tmpfile (mktemp)
        cat >$tmpfile
        eval (bash-env-json $tmpfile | __bash-env-from-json)
        rm -f $tmpfile
    end
end

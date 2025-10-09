function bash-env
    # alas this pollutes the environment
    function __bash-env-set-vars
        python -c 'import sys, json; d = json.load(sys.stdin); print(";".join([f"set -gx {k} \'{v.replace("\\\\", "\\\\\\\\").replace("\'", "\\\\\'")}\'" for (k,v) in d["env"].items()] + [f"set -g {k} \'{v.replace("\\\\", "\\\\\\\\").replace("\'", "\\\\\'")}\'" for (k,v) in d["shellvars"].items()]))'
    end

    if test (count $argv) -gt 0
        eval (bash-env-json $argv | __bash-env-set-vars)
    else
        # capture stdin into a temporary file and pass that to bash-env-json
        set -l tmpfile (mktemp)
        cat >$tmpfile
        eval (bash-env-json $tmpfile | __bash-env-set-vars)
        rm -f $tmpfile
    end
end

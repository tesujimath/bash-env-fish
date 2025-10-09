function bash-env
    # alas this pollutes the environment
    function __bash-env-from-json
        python -c '
import sys, json
d = json.load(sys.stdin)
def escape(s):
    """Escape backslashes and single quotes."""
    return s.replace("\\\\", "\\\\\\\\").replace("\'", "\\\\\'")

print(";".join(
  [f"set -gx {k} \'{escape(v)}\'" for (k,v) in d["env"].items() if v is not None] +
  [f"set -e {k}" for (k,v) in d["env"].items() if v is None] +
  [f"set -g {k} \'{escape(v)}\'" for (k,v) in d["shellvars"].items()]))
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

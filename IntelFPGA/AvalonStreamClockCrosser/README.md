Run `post-ipgenerate.sh` after `quartus_ipgenerate` to workaround
issue in Intel's code gen (use of `sed` to ensure the `DATA_WIDTH`
parameter is actually used to define the Avalon stream width).

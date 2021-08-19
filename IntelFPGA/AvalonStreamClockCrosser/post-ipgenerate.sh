#! /usr/bin/env bash

# This script should be run after quartus_ipgenerate to workaround
# issues in Intel's code gen.

IPDIR=$(dirname $0)

# Due to a bug in Intel's code gen for the clock crossing IP,
# we use sed to ensure the DATA_WIDTH parameter is actually used
# to define the Avalon stream width

AVL_ST_CC=$IPDIR/AvalonStreamClockCrosser/synth/AvalonStreamClockCrosser.v
if [ ! -f $AVL_ST_CC ]; then
  echo "ERROR: not found: $AVL_ST_CC"
  echo "This script should be run after quartus_ipgenerate"
  exit -1
fi
sed -i 's/\[7:0\] in_data/[DATA_WIDTH-1:0] in_data/g' $AVL_ST_CC
sed -i 's/\[7:0\] out_data/[DATA_WIDTH-1:0] out_data/g' $AVL_ST_CC

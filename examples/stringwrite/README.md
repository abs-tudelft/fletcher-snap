Set up Vivado environment / source Vivado script.

In SNAP directory:
```
source snap_path.sh
make snap_config
```

Choose HDL.

Contents of snap env.sh:
```
export PSLVER=9
export TIMING_LABLIMIT="-200"
export ACTION_ROOT=/path/to/fletcher-snap/examples/stringwrite
export PSL9_IP_CORE=
export PSLSE_ROOT=/path/to/pslse
```

In SNAP directory:
```
make model
```

In ```/path/to/fletcher-snap/examples/stringwrite/sw``` directory:
```
make
```

In SNAP directory:
```
make sim
```

A terminal window should pop up. Here we run:
```
snap-maint -vvv
/path/to/fletcher-snap/examples/stringwrite/sw/snap_stringwrite
exit
```

See waveforms, in SNAP directory:
```
xsim -gui hardware/sim/xsim/latest/top.wdb
```
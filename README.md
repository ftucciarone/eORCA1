# eORCA1
Instructions to compile and run a global circulation configuration with NEMO 4.2

[!Note]
Nemo 4.2 is incompatible with XIOS-2.5. This configuration has to be linked against Xios-trunk

#### Compilation of the base cofiguration
1) The eOrca1 configuration can be built starting from the shipped reference configuration `ORCA2_ICE_PISCES`. First, lets duplicate this configuration with the command
```shell
./makenemo -m 'local' -r ORCA2_ICE_PISCES -n 'OrcaDef1' -j 0;
```
where `-j 0` sets the number of processors for compilation to 0: with this peculiar choice the command `./makenemo` will only duplicate and rename the necessary files without compiling.

2) Modify the `cpp_*.fcm`: the file `cfgs/OrcaDef1/cpp_OrcaDef1.fcm should contain the following line
```
bld::tool::fppkeys   key_si3 key_xios key_qco key_isf
```

3) Compile the code
```shell
./makenemo -m 'local' -r ORCA2_ICE_PISCES -n 'OrcaDef1' -j 32;
```

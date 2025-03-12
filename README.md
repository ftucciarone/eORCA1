# eORCA1
Instructions to compile and run a global circulation configuration with NEMO 4.2

> [!IMPORTANT]  
> Nemo 4.2 is incompatible with XIOS-2.5. This configuration has to be linked against Xios-trunk

#### Compilation of the base cofiguration
1) The eOrca1 configuration can be built starting from the shipped reference configuration `ORCA2_ICE_PISCES`. First, lets duplicate this configuration with the command
```shell
./makenemo -m 'local' -r ORCA2_ICE_PISCES -n 'OrcaDef1' -j 0;
```
where `-j 0` sets the number of processors for compilation to 0: with this peculiar choice the command `./makenemo` will only duplicate and rename the necessary files without compiling.

2) Modify the `cpp_*.fcm`: the file `cfgs/OrcaDef1/cpp_OrcaDef1.fcm` should contain the following line
```
bld::tool::fppkeys   key_si3 key_xios key_qco key_isf
```

3) Compile the code
```shell
./makenemo -m 'local' -r ORCA2_ICE_PISCES -n 'OrcaDef1' -j 32;
```

# Changes from 4.0 to 4.2 that are relevant for LU
1) **Elimination of inner-domain pointers**
```shell
/home/ftucciarone/ithaca/Orca1/nemo_4.2/cfgs/lu_Orca1/BLD/ppsrc/nemo/tlu_prj.f90:204:18:

  204 |       zwa1(1:jpim1,2:jpj-1,1:jpk-1) =       uin(1:jpim1,1:jpjm1,1:jpkm1) -                                &
      |                  1
Error: Symbol ‘jpim1’ at (1) has no IMPLICIT type
/home/ftucciarone/ithaca/Orca1/nemo_4.2/cfgs/lu_Orca1/BLD/ppsrc/nemo/tlu_prj.f90:204:63:

  204 |       zwa1(1:jpim1,2:jpj-1,1:jpk-1) =       uin(1:jpim1,1:jpjm1,1:jpkm1) -                                &
      |                                                               1
Error: Symbol ‘jpjm1’ at (1) has no IMPLICIT type
fcm_internal compile failed (256)
```
`jpim1` and `jpjm1` has been removed from `par_oce.F90`. Thus there is the need to instantiate them. Add
```fortran
      INTEGER ::   jpim1  !: inner domain indices
      INTEGER ::   jpjm1  !:   -     -      -
      jpim1  = jpi-1
      jpjm1  = jpj-1
```
where it is needed:
- [x] `tlu_prj.F90`
> [!TIP]
> Could be interesting to see if those has been substituted by an inner-domain pointer wrt the 2-points halo
2) **Change of `rn_rdt`**: it has been renamed `rDt` (and `r1_rDt` has been introduced)
```shell
/home/ftucciarone/ithaca/Orca1/nemo_4.2/cfgs/lu_Orca1/BLD/ppsrc/nemo/tlu.f90:369:37:

  369 |          dt_delay = dt_delay / rn_rdt
      |                                     1
Error: Symbol ‘rn_rdt’ at (1) has no IMPLICIT type
```
has been modified as
```fortran
         !
         ! Set up the delay
         !
         dt_delay = dt_delay / rDt
```
3) numnam_ref and numnam_cfg have been changed??

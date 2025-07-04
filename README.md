# eORCA1
Instructions to compile and run a global circulation configuration with NEMO 5.0.1

## Download and (hopefully) compile NEMO
Download the Nemo code from GitLab, this can be done 'checking out' the 5.0 or 5.0.1 release from GitLab as
```shell
git clone --branch 5.0.1 https://forge.nemo-ocean.eu/nemo/nemo.git nemo-5.0.1
```
The [NEMO Ocean Engine Reference manual](https://zenodo.org/records/14515373) has been updated for version 5.0 and can be downloaded at [https://zenodo.org/records/14515373 (direct download)](https://zenodo.org/records/14515373/files/NEMO_manual.pdf?download=1). 

> [!TIP] 
> If your architecture is not set up you can set it up with the `./build_arch-auto.sh` tool inside the `arch/` directory. Assuming NectCDF-C, NetCDF-F and HDF5 installed, you should have tools called `nc-config`, `nf-config` and `h5pcc`. Locate those tools (e.g. `which nc-config`) or alias them to the correct path and provide the path to `./build_arch-auto.sh` as:
> ```shell
> cd arch
> ./build_arch-auto.sh --NETCDF_C_prefix /path/to/nc-config --NETCDF_F_prefix /path/to/nf-config --HDF5_prefix /path/to/HDF5  --XIOS_prefix /path/to/XIOS
> ```
> where `/path/to/HDF5` can be found with `h5pcc -showconfig`. The path to XIOS is actually the download folder of XIOS. This tool with create the architecture file `arch/arch-auto.fcm`.

#### Test the installation trying to compile a simple configuration, e.g. the Gyre configuration:
```shell
./makenemo -m 'auto' -r GYRE_PISCES -n 'MY_GYRE' -j 8
```
if the compilation is successful you should be able to run Nemo with
```shell
cd cfgs/MY_GYRE/EXP00
./nemo
```
and then remove it if not needed
```shell
./makenemo -m 'auto' -r GYRE_PISCES -n 'MY_GYRE' -j 8 clean_config
```

## Donwload the data repository (courtesy of Casimir de Lavergne)
![<img src="[path/to/image.png](https://orcid.org/assets/vectors/orcid.logo.icon.svg)">]()
```shell
wget https://zenodo.org/records/14041098/files/data_repository.zip
```

## Compilation of the base cofiguration
1) The eOrca1 configuration can be built starting from the shipped reference configuration `ORCA2_ICE_PISCES`. First, lets duplicate this configuration with the command
```shell
./makenemo -m 'local' -r ORCA2_ICE_PISCES -n 'eOrca1' -j 0;
```
where `-j 0` sets the number of processors for compilation to 0: with this peculiar choice the command `./makenemo` will only duplicate and rename the necessary files without compiling.

2) Modify the `cpp_*.fcm`: the file `cfgs/OrcaDef1/cpp_OrcaDef1.fcm` should contain the following line
```
bld::tool::fppkeys   key_si3 key_xios key_qco key_isf key_vco_1d3d key_RK3
```

3) Compile the code
```shell
./makenemo -m 'local' -r ORCA2_ICE_PISCES -n 'eOrca1' -j 32;
```

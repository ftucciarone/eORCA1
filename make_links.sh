#!/bin//bash
static_dir=/home/ftucciarone/ithaca/Orca1/data_repository

#
# Input domain file
#
ln -sf $static_dir/input_fields/domain_cfg.nc .

#
# Input domain file
#
ln -sf $static_dir/restart/*.nc .

# Rivers run-off
ln -sf $static_dir/input_fields/runoff-icb_DaiTrenberth_Depoorter.nc .
# Is this a radiation of some sort?
ln -sf $static_dir/input_fields/zdfiwm_forcing_TRA.nc .
# Geothermal heat flux
ln -sf $static_dir/input_fields/geothermal_heat_flux.nc .
# Eddy viscosity (3D)
ln -sf $static_dir/input_fields/eddy_viscosity_3D.nc .
# Climatology SSS restoring
ln -sf $static_dir/input_fields/sss_climatology_for_restoring.nc .

ln -sf $static_dir/input_fields/merged_ESACCI_BIOMER4V1R1_CHL_REG05.nc .
#
# On-the-fly interpolation weights
#
ln -sf $static_dir/input_fields/weights_ghflux_bilinear.nc .
ln -sf $static_dir/input_fields/weights_reg05_bilinear.nc .
#
# Initial conditions
#
ln -sf $static_dir/initial_conditions/woce_temp_monthly_init_4p2.nc .
ln -sf $static_dir/initial_conditions/woce_salt_monthly_init_4p2.nc .
#
# Forcings
#
ln -sf $static_dir/forcing_ORCA1/* .

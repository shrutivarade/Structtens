clc;
clear;
close all;
addpath matlab2/StructureTensor_toolbox/code3D;

% Replace the following path with the actual path to your NIfTI file
Hip_CT_nifti_file = '/autofs/space/aspasia_002/users/code/structens/tractography-testset/I58_hipct/484um_rotated/4bin_rotate_rescale_121.04um_I58.nii';
% Read the NIfTI file
x = MRIread(Hip_CT_nifti_file);
%Print data
x
% The 3D volume data is now stored in x.vol
volume_data = x.vol;
% Access a specific voxel's intensity (i, j, k are indices for the voxel)
intensity = volume_data(1, 1, 1);

%% %%%%%%%%%%%%%%%%%%%%%%% Compute convex hull
% Thresh = 0.1; 
% ConvInfo = ConvexHullCells3D(im, Thresh, dlt);

%% %%%%%%%%%%%%%%%%%%%% Compute structural tensor 
rho = 10; 
dlt = [1,1,1];
EigInfo = coherence_orientation3D(volume_data, rho, dlt);
disp(EigInfo);

%% %%%%%%%%%%%%%%%%%%%%% Display info
% para.Step  = 10; 
% DisplayImage3D(im, EigInfo, ConvInfo, para);


nii = x;
nii.vol = EigInfo.w3;
% Define the output file path for saving the tensor as a NIfTI file
output_nifti_file = '/autofs/space/atropos_001/users/shruti/Github/Structtens/output/rho10_sigma8.nii';

MRIwrite(nii, output_nifti_file);

% Confirm the save
disp(['Structure tensor saved as ', output_nifti_file]);


clc;
clear;
close all;
addpath StructureTensor_toolbox/code3D;

%% %%%%%%%%%%%%%%%%%%%%%%% Load the NIfTI file
Hip_CT_nifti_file = '/autofs/space/aspasia_002/users/code/structens/tractography-testset/I58_hipct/484um_rotated/4bin_rotate_rescale_121.04um_I58.nii';

%% %%%%%%%%%%%%%%%%%%%%%%%% Read the image
im = double(niftiread(Hip_CT_nifti_file))/255; 
dlt = [1 1 1];  

%% %%%%%%%%%%%%%%%%%%%%%%% Compute convex hull
Thresh = 0.1; 
ConvInfo = ConvexHullCells3D(im, Thresh, dlt);

%% %%%%%%%%%%%%%%%%%%%% Compute structural tensor 
rho = 5; 
EigInfo = coherence_orientation3D(im, rho, dlt);

%% %%%%%%%%%%%%%%%%%%%%% Display info
para.Step  = 10; 
% DisplayImage3D(im, EigInfo, ConvInfo, para);



% Replace the following path with the actual path to your NIfTI file
Hip_CT_nifti_file = '/autofs/space/aspasia_002/users/code/structens/tractography-testset/I58_hipct/484um_rotated/4bin_rotate_rescale_121.04um_I58.nii';

% Read the NIfTI file
x = MRIread(Hip_CT_nifti_file);

%Print data
x

% The 3D volume data is now stored in x.vol
volume_data = x.vol;

% Access a specific voxel's intensity (i, j, k are indices for the voxel)
intensity_value = volume_data(1, 1, 1);


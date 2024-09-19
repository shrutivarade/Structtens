clc; clear all; close all;

% Load the data
Hip_CT_nifti_file = '/autofs/space/aspasia_002/users/code/structens/tractography-testset/I58_hipct/484um_rotated/4bin_rotate_rescale_121.04um_I58.nii';

% Read the NIfTI file
x = MRIread(Hip_CT_nifti_file);

% The 3D volume data is now stored in x.vol
volume_data = x.vol;

% Specific voxel's intensity (optional)
intensity_value = volume_data(1, 1, 1);

% Add the Structure Tensor Toolbox to the MATLAB path
addpath(genpath('/autofs/space/atropos_001/users/shruti/structtens/StructureTensor_toolbox/code3D'));

% Parameters
sigma = 0.5;
rho = 1;
dlt = [1 1 1]; % voxel size in each dimension (you can adjust as needed)

% Calculate structure tensor
[Tensor, im_sigma] = structure_tensor3D(volume_data, sigma, rho, dlt);

% Define the output file path for saving the tensor as a NIfTI file
output_nifti_file = '/autofs/space/atropos_001/users/shruti/Github/Structtens/output/ST_m2_Ornt.nii';

% Prepare the NIfTI header by copying from the original NIfTI file
info = niftiinfo(Hip_CT_nifti_file);

% Save the Tensor as a NIfTI file
niftiwrite(Tensor, output_nifti_file);

% Confirm the save
disp(['Structure tensor saved as ', output_nifti_file]);

% Function to compute the 3D structure tensor
% function [Tensor, im_sigma] = structure_tensor3D(im, sigma, rho, dlt)
%     % structure_tensor3D computes the structure tensor matrix for 3D images.
%     % Input:
%     % im - 3D input image
%     % sigma - standard deviation of the Gaussian kernel (for smoothing)
%     % rho - standard deviation for tensor averaging
%     % dlt - voxel size in each dimension
%     % Output:
%     % Tensor - structure tensor matrix (9 components: J11, J12, J13, J22, J23, J33)
%     % im_sigma - smoothed image
% 
%     [nx, ny, nz] = size(im);
% 
%     % Gaussian kernel convolution applied to the image
%     if sigma == 0
%         im_sigma = im;
%     else
%         gk_sigma = gaussian_kernel3D(nx, ny, nz, sigma, dlt);  
%         im_sigma = ifftn(fftn(gk_sigma) .* fftn(im));
%     end
% 
%     % Gradient computation (finite differences)
%     grad = zeros(nx, ny, nz, 3);
%     grad(:, :, :, 1) = gradient(im_sigma, dlt(1), 'x');
%     grad(:, :, :, 2) = gradient(im_sigma, dlt(2), 'y');
%     grad(:, :, :, 3) = gradient(im_sigma, dlt(3), 'z');
% 
%     % Structure tensor calculation (9 components)
%     Tensor = zeros(nx, ny, nz, 9);
%     for i = 1:3
%         for j = i:3
%             Tensor(:,:,:, (i-1)*3 + j) = grad(:,:,:,i) .* grad(:,:,:,j);
%         end
%     end
% 
%     % Ensure symmetry in the tensor
%     for i = 2:3
%         for j = 1:i-1
%             Tensor(:,:,:, (i-1)*3 + j) = Tensor(:,:,:, (j-1)*3 + i);
%         end
%     end
% 
%     % Apply Gaussian smoothing to each tensor component
%     gk_rho = fftn(gaussian_kernel3D(nx, ny, nz, rho, dlt));
%     for i = 1:9
%         Tensor(:,:,:,i) = ifftn(gk_rho .* fftn(Tensor(:,:,:,i)));
%     end
% end
% 
% % Gaussian kernel function for 3D images
% function gk = gaussian_kernel3D(nx, ny, nz, sigma, dlt)
%     % Create a 3D Gaussian kernel with size based on the image dimensions
%     [X, Y, Z] = ndgrid((-nx/2:nx/2-1) * dlt(1), (-ny/2:ny/2-1) * dlt(2), (-nz/2:nz/2-1) * dlt(3));
%     gk = exp(-(X.^2 + Y.^2 + Z.^2) / (2 * sigma^2));
%     gk = gk / sum(gk(:)); % Normalize
% end

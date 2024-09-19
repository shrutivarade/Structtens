import numpy as np
import cupy as cp
import nibabel as nib
from structure_tensor.cp import eig_special_3d, structure_tensor_3d
import time

# Start time
start_time = time.time()

# Function to save tensor arrays
def save_tensor_arrays(filename, tensor_data):
    np.save(filename, tensor_data)

# Replace 'your_file.nii' with the path to your NIfTI file
nifti_file = '/space/aspasia/2/users/code/structens/tractography-testset/I58_hipct/484um_rotated/4bin_rotate_rescale_121.04um_I58.nii'

# Load NIfTI file
img = nib.load(nifti_file)
volume = img.get_fdata()

# Transfer data to CuPy array
volume_cp = cp.array(volume)

# Parameters for the structure tensor calculation
sigma = 0.5
rho = 1

# Compute the structure tensor using CuPy
S_cp = structure_tensor_3d(volume_cp, sigma, rho)

# Compute eigenvalues and eigenvectors using CuPy
val_cp, vec_cp = eig_special_3d(S_cp)

# Transfer eigenvectors back to NumPy array
vec_normalized = cp.asnumpy(vec_cp)

# Normalize eigenvectors (if required)
vec_normalized /= np.linalg.norm(vec_normalized, axis=0, keepdims=True)

# Ensure the shape of vec_normalized matches volume_shape + (3,)
if vec_normalized.shape != (3, *volume.shape):
    raise ValueError("Shape mismatch between volume and vectors")

# Transpose to shape (972, 972, 100, 3) for RGB format
vec_normalized_rgb = np.transpose(vec_normalized, (1, 2, 3, 0))

# Save eigenvectors as a RGB NIfTI file
output_file = '/space/atropos/1/users/shruti/Github/Structtens/output/python-implementation'
nib.save(nib.Nifti1Image(vec_normalized_rgb.astype(np.float32), img.affine), output_file)

# print(f"Eigenvectors saved as {output_file}")

# End time
end_time = time.time()

# Calculate the execution time
execution_time = end_time - start_time
print(f"Time taken to execute: {execution_time} seconds")
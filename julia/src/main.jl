# module script

using NIfTI
# using Images

# include("gaussian_kernel3D.jl")
# include("utilities.jl")
# include("convex_hull_cells3D.jl")
# include("coherence_orientation3D.jl")
# include("structure_tensor3D.jl")

# Load a NIfTI 3D image
function load_image(file_path)
    nii = NIfTI.niread(file_path)
    # println(nii)
    println(nii.header)
    return nii.header 
end

# Main processing function
function process_image(image_path)
    im = load_image(image_path)
    dlt = [1, 1, 1]  # Aspect ratio for the voxels, adjust as needed

    # Compute convex hull information
    # thresh = 0.1
    # conv_info = convex_hull_cells3D(im, thresh, dlt)

    # Compute structure tensor and coherence orientation
    # rho = 5
    # eig_info = coherence_orientation3D(im, rho, dlt)

    # Placeholder for any display or further processing
    println("Processing complete.")
end

# Specify the image path and call the process function
image_path = "/autofs/space/aspasia_002/users/code/structens/tractography-testset/I58_hipct/484um_rotated/4bin_rotate_rescale_121.04um_I58.nii"
process_image(image_path)

# end
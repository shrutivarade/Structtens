# using NIfTI
# using Images
# include("gaussian_kernel3D.jl")
# include("utilities.jl")
# include("convex_hull_cells3D.jl")
# include("coherence_orientation3D.jl")
# include("structure_tensor3D.jl")

# # Load a NIfTI 3D image
# function load_image(file_path)
#     nii = NIfTI.niread(file_path)
#     return Float64.(nii.data) / 255  # Normalize image data
# end

# # Main processing function
# function process_image(image_path)
#     im = load_image(image_path)
#     dlt = [1, 1, 1]  # Aspect ratio for the voxels, adjust as needed

#     # Compute convex hull information
#     thresh = 0.1
#     conv_info = convex_hull_cells3D(im, thresh, dlt)

#     # Compute structure tensor and coherence orientation
#     rho = 5
#     eig_info = coherence_orientation3D(im, rho, dlt)

#     # Placeholder for any display or further processing
#     println("Processing complete.")
# end

# # Specify the image path and call the process function
# image_path = "path_to_your_image.nii"
# process_image(image_path)

println("It works")
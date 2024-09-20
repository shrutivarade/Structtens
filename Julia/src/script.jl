

using NIfTI

image_path = "/autofs/space/aspasia_002/users/code/structens/tractography-testset/I58_hipct/484um_rotated/4bin_rotate_rescale_121.04um_I58.nii"

ni = niread(image_path)

println(ni.header)
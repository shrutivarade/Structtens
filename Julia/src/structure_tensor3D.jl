function structure_tensor3D(im, sigma, rho, dlt)
    # Apply Gaussian filtering based on sigma and rho
    gk_sigma = gaussian_kernel3D(size(im)..., sigma, dlt)
    im_sigma = imfilter_fft(im, gk_sigma)

    # Compute gradients and tensor products
    grad = gradient(im_sigma)
    tensor = compute_tensor(grad)

    # Further Gaussian filtering
    gk_rho = gaussian_kernel3D(size(im)..., rho, dlt)
    tensor_smoothed = imfilter_fft(tensor, gk_rho)

    println("Structure tensor computed.")
    return tensor_smoothed, im_sigma
end

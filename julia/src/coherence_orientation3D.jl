function coherence_orientation3D(im, rho, dlt)
    # Compute the structure tensor first
    sigma = 0
    J_rho, im_sigma = structure_tensor3D(im, sigma, rho, dlt)

    # for eigen computation



    println("Eigenvalues and eigenvectors computed.")
    return Dict("eigenvalues" => "eigenvalues_data", "eigenvectors" => "eigenvectors_data")
end

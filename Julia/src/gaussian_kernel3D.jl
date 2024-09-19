using ImageFiltering

function gaussian_kernel3D(nx, ny, nz, sigma, dlt)
    if sigma == 0
        return ones(nx, ny, nz)
    else
        return Kernel.gaussian((sigma/dlt[1], sigma/dlt[2], sigma/dlt[3]))
    end
end

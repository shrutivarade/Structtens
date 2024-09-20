function gradient(im)
    # Compute 3D gradients
    return cat(3, imfilter(im, centered([-1 0 1])), imfilter(im, centered([-1 0 1])'), imfilter(im, permutedims(centered([-1 0 1]), [1, 3, 2])))
end

function compute_tensor(grad)
    # Compute tensor product of gradients
    tensor = similar(grad, size(grad)..., 3)
    for i in 1:3
        for j in i:3
            tensor[:, :, :, i, j] = grad[:, :, :, i] .* grad[:, :, :, j]
            if i != j
                tensor[:, :, :, j, i] = tensor[:, :, :, i, j]
            end
        end
    end
    return tensor
end

function imfilter_fft(im, kernel)
    # FFT-based filtering

    
    return real(ifft(fft(im) .* fft(kernel, size(im))))
end

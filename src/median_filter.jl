function median_filter!(v::AbstractVector, window::Int, i::Int)
    if iseven(window)
        throw(ArgumentError("window must be odd to have a center element"))
    end
    if i > (window÷2) && i < (length(v) - (window÷2 - 1))
        v[i] = median(v[i-window÷2:i+window÷2])
    end
    return v
end

function median_filter(v::AbstractVector, window::Int, i::Int)
    _v = copy(v)
    return median_filter!(_v, window, i)
end

function median_filter!(v::AbstractVector, window::Int)
    for i in eachindex(v)
        median_filter!(v, window, i)
    end
    return v
end

function median_filter!(v::AbstractVector, window::Int, pixels::AbstractVector)
    for i in pixels
        median_filter!(v, window, i)
    end
    return v
end

"""
    median_filter(v, window)

A naive filter that takes the median value of the 
neighboring values in a vector for a given window size.
"""
function median_filter(v::AbstractVector, window::Int)
    _v = copy(v)
    return median_filter!(_v, window)
end

"""
    median_filter(v, window, pixels)

A naive filter that takes the median value of the
neighboring values in a vector for a given window size.
The filter is only applied to the pixels specified in `pixels`.
"""
function median_filter(v::AbstractVector, window::Int, pixels::AbstractVector)
    _v = copy(v)
    return median_filter!(_v, window, pixels)
end


function median_filter!(A::AbstractArray, window::Int, i::Int, j::Int)
    if iseven(window)
        throw(ArgumentError("window must be odd to have a center element"))
    end

    neighborhood = zeros(window^2)  # Create a list to store the neighborhood pixels
    half_size = div(window, 2)
    i_start, i_end = max(1, i - half_size), min(size(A, 1), i + half_size)
    j_start, j_end = max(1, j - half_size), min(size(A, 2), j + half_size)
    neighborhood = A[i_start:i_end, j_start:j_end]

    # Replace the pixel value with the median of the neighborhood
    A[i, j] = median(neighborhood)
    return A
end

function median_filter(A::AbstractArray, window::Int, i::Int, j::Int)
    _A = copy(A)
    median_filter!(_A, window, i, j)
    return _A
end


function median_filter!(A::AbstractArray, window::Int)
    for i in 1:size(A, 1)
        for j in 1:size(A, 2)
            median_filter!(A, window, i, j)
        end
    end
    return A
end

function median_filter(A::AbstractArray, window::Int)
    _A = copy(A)
    return median_filter!(_A, window)
end


# """
#     median_filter!(A, pxls, dim=1)

# Apply a median filter to a pixel band in `pxls` along dimension `dim` of matrix `A`.
# """
# function band_filter!(A, window, pxls, dim=1)
#     for (i, row) in enumerate(eachrow(A))
#         for (j, col) in enumerate(eachcol(A))
#             pixeldim = i
#             if dim == 2
#                 pixeldim = j
#             end
#             if pixeldim in pxls
#                 if j != 1 && j != lastindex(A[:, j])
#                     median_filter!(A, window, i, j)
#                 end
#             end
#         end
#     end
#     return A
# end

# function band_filter(A, window, pixels, dim=1)
#     _A = copy(A)
#     band_filter!(_A, window, pixels, dim)
#     return _A
# end

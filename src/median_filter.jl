"""
    median_filter(A::AbstractMatrix, i::Int, j::Int)

A naive filter that takes the median value of the four 
neighboring (non-diagonal) values in matrix `A` around index `(i, j)`.
"""
function median_filter(A::AbstractArray, i::Int, j::Int, window_size::Int=1)
    _A = copy(A)
    median_filter!(_A, i, j, window_size)
    return _A
end

"""
    median_filter!(A, i, j, window_size)

Like `median_filter(A, i, j, window_size)` but the input matrix may be replaced.
"""
function median_filter!(A::AbstractArray, i::Int, j::Int, window_size::Int=1)
    if iseven(window_size)
        throw(ArgumentError("window_size must be odd to have a center element"))
    end

    # Create a list to store the neighborhood pixels
    neighborhood = zeros(window_size^2)
    half_size = div(window_size, 2)
    i_start, i_end = max(1, i - half_size), min(size(A, 1), i + half_size)
    j_start, j_end = max(1, j - half_size), min(size(A, 2), j + half_size)
    neighborhood = A[i_start:i_end, j_start:j_end]

    # Replace the pixel value with the median of the neighborhood
    A[i, j] = median(neighborhood)
end


"""
    median_filter(v, i)

A naive filter that takes the median value of the two 
neighboring values in a vector `v` around index `i`.
"""
function median_filter(v::AbstractVector, i::Int)
    _v = copy(v)
    median_filter!(_v, i)
    return _v
end

"""
    median_filter!(v, i)

Like `median_filter(v, i)` but the input vector may be replaced.
"""
function median_filter!(v::AbstractVector, i::Int)
    v[i] = median([v[i], v[i+1], v[i-1]])
end


"""
    median_filter!(A, pxls, dim=1)

Apply a median filter to a pixel band in `pxls` along dimension `dim` of matrix `A`.
"""
function median_filter!(A, pxls, dim=1)
    for (i, row) in enumerate(eachrow(A))
        for (j, col) in enumerate(eachcol(A))
            pixeldim = i
            if dim == 2
                pixeldim = j
            end
            if pixeldim in pxls
                if j != 1 && j != lastindex(A[:, j])
                    median_filter!(A, i, j, 3)
                end
            end
        end
    end
end

"""
    median_filter(A, pxls, dim=1)

Like `band_filter!(A, pxls, dim=1)` but the input matrix may be replaced.
"""
function band_filter(A, pxls, dim=1)
    _A = copy(A)
    band_filter!(_A, pxls, dim)
    return _A
end

"""
    median_filter(A::AbstractMatrix, i::Int, j::Int)

A naive filter that takes the median value of the four 
neighboring (non-diagonal) values in matrix `A` around index `(i, j)`.
"""
function median_filter(A::AbstractMatrix, i::Int, j::Int)
    A = copy(A)
    A[i, j] = median([A[i, j], A[i+1, j], A[i-1, j], A[i, j+1], A[i, j-1]])
    return A
end

"""
    median_filter!(A, i, j)

Like `median_filter(A, i, j)` but the input matrix may be replaced.
"""
function median_filter!(A::AbstractMatrix, i::Int, j::Int)
    A[i, j] = median([A[i, j], A[i+1, j], A[i-1, j], A[i, j+1], A[i, j-1]])
end

"""
    median_filter(v, i)

A naive filter that takes the median value of the two 
neighboring values in a vector `v` around index `i`.
"""
function median_filter(v::AbstractVector, i::Int)
    v = copy(v)
    v[i] = median([v[i], v[i+1], v[i-1]])
    return v
end

"""
    median_filter!(v, i)

Like `median_filter(v, i)` but the input vector may be replaced.
"""
function median_filter!(v::AbstractVector, i::Int)
    v[i] = median([v[i], v[i+1], v[i-1]])
end

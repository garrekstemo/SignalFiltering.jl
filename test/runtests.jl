using Test
using SignalFiltering

@testset "median_filter!" begin

    # Test filtering one pixel
    v = ones(Int, 10)
    v[5] = 9
    v_new = median_filter(v, 3, 5)
    @test v_new == ones(Int, length(v))

    v[5] = 9
    median_filter!(v, 3, 5)
    @test v == ones(Int, length(v))

    # Test vectors
    v = ones(Int, 100)
    v[9] = 3
    v[11] = 5
    v[76] = 10
    v_new = median_filter(v, 7)
    @test v_new == ones(Int, length(v))

    median_filter!(v, 7)
    @test v == ones(Int, length(v))

    v = ones(Int, 10)
    v[2] = 3
    v[10] = 5
    v_new = median_filter(v, 3)
    @test v_new == [1, 1, 1, 1, 1, 1, 1, 1, 1, 5]

    median_filter!(v, 3)
    @test v == [1, 1, 1, 1, 1, 1, 1, 1, 1, 5]

    v = ones(Int, 10)
    v[2] = 3
    v[9] = 5
    v_new = median_filter(v, 3)
    @test v_new == ones(Int, length(v))

    median_filter!(v, 3)
    @test v == ones(Int, length(v))

    # Test selecting individual pixels to filter
    v = ones(Int, 10)
    v[2] = 9
    v[5] = 9
    v[7] = 9
    v_new = median_filter(v, 3, [2, 5, 7])
    @test v_new == ones(Int, length(v))

    median_filter!(v, 3, [2])
    @test v == [1, 1, 1, 1, 9, 1, 9, 1, 1, 1]

    median_filter!(v, 3, [5, 7])
    @test v == ones(Int, length(v))


    # Test filtering a matrix
    A = ones(Int, 10, 10)
    A[5, 5] = 9
    A_new = median_filter(A, 3, 5, 5)
    @test A_new == ones(Int, size(A))

    A[5, 5] = 9
    @test median_filter!(A, 3, 5, 5) == ones(Int, size(A))

    A[2, 2] = 9
    A[5, 5] = 9
    A_new = median_filter(A, 3)
    @test A_new == ones(Int, size(A))

    A[2, 2] = 9
    A[5, 5] = 9
    median_filter!(A, 3)
    @test A == ones(Int, size(A))


    # Test band filter
    A = ones(Int, 10, 10)
    A[2, 7] = 9
    A_new = band_filter!(A, 3, [7])
    @test A_new == ones(Int, size(A))
end
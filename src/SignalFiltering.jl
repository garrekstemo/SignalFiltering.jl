module SignalFiltering

export  median_filter,
        median_filter!,
        band_filter,
        band_filter!

using Statistics

include("median_filter.jl")

end
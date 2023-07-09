using SignalFiltering
using GLMakie
GLMakie.activate!(inline=false)

function lorentz2d(x, y, A, ω_0, Γ)
    data = zeros(length(x), length(y))
    for i in eachindex(x)
        for j in eachindex(y)
            data[i, j] = A * Γ ./ ((x[i] .- ω_0) .^2 + (y[j]) .^2 .+ Γ^2)
        end
    end
    data
end

function deadpixels(A, fixed, space, val)
    for (i, row) in enumerate(eachrow(A))
        if mod(i, space) == 0
            A[fixed, i] = val
        end
    end
end

x = -7:0.1:7
y = -7:0.1:7
Γ = 2
A = 40
ω1 = -2
ω2 = 2
z = lorentz2d(x, y, A, ω1, Γ) .- lorentz2d(x, y, A, ω2, Γ)

deadpixels(z, 40, 9, 20)
deadpixels(z, 38, 13, -20)

# Using GLMakie
fig = Figure(resolution = (1200, 2100))
DataInspector()

levels = minimum(z)-2:1:maximum(z)+2
ax1 = Axis(fig[1, 1], title = "raw", xticks = x[1]:x[end], yticks = y[1]:2:y[end])
ct1 = contourf!(x, y, z, levels=levels, colormap = :RdBu)
contour!(x, y, z, levels=levels, linewidth = 0.5, color = :black)
Colorbar(fig[1, 2], ct1, label = "Intensity")

band_filter(z, 37:40, 1)

zax2 = Axis(fig[2, 1], title = "filtered", xticks = x[1]:2:x[end], yticks = y[1]:5:y[end])
ct2 = contourf!(x, y, z, levels=levels, colormap = :RdBu)
contour!(x, y, z, levels=levels, linewidth = 0.5, color = :black)
Colorbar(fig[2, 2], ct2, label = "Intensity")

fig
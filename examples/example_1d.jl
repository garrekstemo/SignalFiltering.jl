using SignalFiltering
using GLMakie

function lorentzian(x, A, ω_0, Γ)
    data = zeros(length(x))
    for i in eachindex(x)
        data[i] = A * Γ / ((x[i] - ω_0)^2 + Γ^2)
    end
    data
end

x = -20:0.3:20
Γ = 2
A = 40
ω1, ω2 = -3, 3
y = lorentzian(x, A, ω1, Γ) .- lorentzian(x, A, ω2, Γ) .+ 0.3 * randn(length(x))

dp1, dp2 = 25, 45
y[dp1] = -10
y[dp2] = 10

fig = Figure(size = (500, 900))
DataInspector()

ax1 = Axis(fig[1, 1], title = "raw")
lines!(x, y)

median_filter!(y, 3, dp1)
median_filter!(y, 3, dp2)

ax2 = Axis(fig[2, 1], title = "filtered")
lines!(x, y)

fig
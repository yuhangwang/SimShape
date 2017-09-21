module Compute
include("GaussianSlab.jl")
include("MajorEllipticTorus.jl")
include("DoubleEllipticTorus.jl")
include("EllipticTube.jl")
include("Tube.jl")
include("Rod.jl")
include("Rods.jl")
include("Sphere.jl")
include("Plane.jl")

function get_fn(shape::AbstractString, params)
    shapes = Dict(
        :GaussianSlab => GaussianSlab.get_fn,
        :MajorEllipticTorus => MajorEllipticTorus.get_fn,
        :DoubleEllipticTorus => DoubleEllipticTorus.get_fn,
        :EllipticTube => EllipticTube.get_fn,
        :Tube => Tube.get_fn,
        :Rod => Rod.get_fn,
        :Rods => Rods.get_fn,
        :Sphere => Sphere.get_fn,
        :Plane => Plane.get_fn,
    )
    return shapes[Symbol(shape)](params)
end
export get_fn
end

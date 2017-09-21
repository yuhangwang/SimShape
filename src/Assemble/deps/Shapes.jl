module Shapes

include("PartialSphere.jl")
include("Cylinder.jl")
include("Grid.jl")
include("PartialTorus.jl")


function choose(shape::Symbol)
    apps = Dict(
            :PartialSphere =>PartialSphere,
            :Cylinder => Cylinder,
            :Grid => Grid,
            :PartialTorus => PartialTorus,
        )
    if shape in keys(apps)
        return apps[shape].assemble
    else
        error("Error hint: shape \"$(string(shape))\" not recognized")
    end
end

end
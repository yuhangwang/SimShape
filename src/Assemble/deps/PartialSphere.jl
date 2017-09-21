module PartialSphere

import SimpleMolecule: Molecule
import MolecularBuild: PartialFibonacciSphere
import MolecularBuild: BuildPartialSphere

function assemble(systems::Array{Molecule,1}, params::Dict)
    return BuildPartialSphere.build(
        PartialFibonacciSphere,
        systems;
        number=convert(Int, params["number"]),
        radius=float(params["radius"]),
        zmin=float(params["zmin"]),
        zmax=float(params["zmax"]),
        center=[float(x) for x in params["center"]],
        old_orientation=Float64[float(x) for x in params["orientation"]],
        aligned=true,
        inverted=params["inverted"]
    )
end

export assemble
end
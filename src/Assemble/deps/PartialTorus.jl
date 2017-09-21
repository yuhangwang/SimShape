module PartialTorus

import SimpleMolecule: Molecule
import MolecularBuild: PartialFibonacciTorus
import MolecularBuild: BuildPartialTorus

function assemble(systems::Array{Molecule,1}, params::Dict)
    return BuildPartialTorus.build(
        PartialFibonacciTorus,
        systems;
        number=convert(Int, params["number"]),
        radius=float(params["radius"]),
        a=float(params["a"]),
        b=float(params["b"]),
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
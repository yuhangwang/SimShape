module Cylinder

import SimpleMolecule: Molecule
import MolecularBuild: FibonacciCylinder, BuildCylinder

function assemble(systems::Array{Molecule,1}, params::Dict)
    return BuildCylinder.build(
        FibonacciCylinder,
        systems;
        number=convert(Int, params["number"]),
        radius=float(params["radius"]),
        zmin=float(params["zmin"]),
        zmax=float(params["zmax"]),
        center=Float64[float(x) for x in params["center"]],
        aligned=true,
        old_orientation=Float64[float(x) for x in params["orientation"]],
        inverted=params["inverted"]
    )
end

end
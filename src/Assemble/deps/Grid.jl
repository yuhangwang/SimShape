module Grid

import SimpleMolecule: Molecule
import MolecularBuild: BuildGrid
import MolecularBuild

function assemble(systems::Array{Molecule,1}, params::Dict)
    return BuildGrid.build(
        MolecularBuild.Grid,
        systems;
        numbers=[convert(Int, x) for x in params["numbers"]],
        directions=[[float(x) for x in xs] for xs in params["directions"]],
        spacings=[float(x) for x in params["spacings"]],
        center=[float(x) for x in params["center"]],
        inverted=params["inverted"],
        randomized=params["randomized"]
    )
end

export assemble
end

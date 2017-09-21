include(joinpath("deps", "ReadMolecule.jl"))
include(joinpath("deps", "Shapes.jl"))
import .ReadMoelcule
import .Shapes
import SimpleMolecule: Molecule, obtain
import MolecularPDB


function main(argd)
    systems = ReadMolecule.read(convert(Array{String,1}, argd["inputs"]))

    fn_assemble = Shapes.choose(Symbol(argd["shape"]))

    @time molecules = fn_assemble(systems, argd["params"])
    new_system = Molecule(vcat([obtain(mol, :atoms) for mol in molecules]...))

    for file_output in argd["outputs"]
        @time MolecularPDB.save(
            MolecularPDB.VMD,
            file_output,
            new_system
        )
    end
end

module ReadMolecule
import MolecularPDB
import SimpleMolecule: Molecule

function read(inputs::Array{String,1})
    # read monomer information
    pdb_style = MolecularPDB.VMD
    get_system(file_pdb::String) = MolecularPDB.read(pdb_style, file_pdb)
    return convert(Array{Molecule,1}, map(get_system, inputs))
end

end

include(joinpath("deps", "Compute.jl"))

using GridDX
using GridShape

function main(argd)
    basis_matrix = eye(3)
    box_size = tuple([convert(Int, x) for x in argd["size"]]...)
    origin = convert(Array{Float64, 1}, argd["origin"])
    for output_file in argd["outputs"]
        fn_compute = Compute.get_fn(argd["shape"], argd["params"])
        @time grid = GridDX.make(
            fn_compute,
            box_size,
            basis_matrix;
            origin=origin
        )

        sizes = [float(x) for x in box_size]
        corner = -sizes/2.0 + origin

        @time GridDX.save(
            output_file,
            GridDX.clone(grid; origin=corner)
        )
    end
end

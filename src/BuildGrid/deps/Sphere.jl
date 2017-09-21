module Sphere

function get_fn(argd::Dict)
    center = [float(x) for x in argd["center"]]
    radius = float(argd["radius"])
    k = float(argd["k"])

    function fn_compute(coordinates)
        d = norm(coordinates - center)
        if d > radius
            return k * d
        else
            return 0.0
        end
    end

    return fn_compute
end

export get_fn
end

module GaussianSlab
function get_fn(argd::Dict)
    center = [float(x) for x in argd["center"]]
    sigma  = float(argd["sigma"])
    k = float(argd["k"])
    upper = float(argd["upper"])
    lower = float(argd["lower"])
    raw_direction = [float(x) for x in argd["direction"]]
    direction = raw_direction/norm(raw_direction)
    function fn_compute(coordinates)
        d = dot(coordinates - center, direction)
        if lower <= d <= upper
            return k * exp(-(d)^2 /(2 *sigma))
        else
            return 0.0
        end
    end

    return fn_compute
end

export get_fn
end

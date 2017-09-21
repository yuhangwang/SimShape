module Plane

function get_fn(argd::Dict)
    center = [float(x) for x in argd["center"]]
    raw_direction = [float(x) for x in argd["direction"]]
    half_height = 0.5 * float(argd["height"])
    k = float(argd["k"])
    power = convert(Int, argd["power"])

    direction = raw_direction/norm(raw_direction)

    function calc(d::AbstractFloat, doCalc::Bool)
        if doCalc
            return (1.0/power) * k * (d^power)
        else
            return 0.0
        end
    end

    function fn_compute(coordinates)
        d = abs(dot(coordinates - center, direction))
        return calc(d, d > half_height)
    end

    return fn_compute
end

export get_fn
end

module Tube

function get_fn(argd::Dict)
    radius = float(argd["radius"])
    k = float(argd["k"])
    center = [float(x) for x in argd["center"]]
    power = argd["exponent"]
    function nomalize{T<:AbstractFloat}(xs::Array{T,1})
        if norm(xs) < 1e-7
            return xs
        else
            return xs / norm(xs)
        end
    end
    direction = normalize([float(x) for x in argd["direction"]])

    function distance{T<:AbstractFloat}(point::Array{T,1})
        p = point - center
        return norm(p - dot(p, direction)*direction)
    end
    function fn_compute(coordinates)
        d = distance(coordinates)
        if d <= radius
            return 0.0
        else
            return 0.5 * k * d^power
        end
    end

    return fn_compute
end

export get_fn
end

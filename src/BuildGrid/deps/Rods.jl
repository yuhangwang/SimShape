module Rods

function get_fn(params::Array)
    function parseParam(p::Dict)
        return Dict(
            :radius => float(p["radius"]),
            :k => float(p["k"]),
            :center => [float(x) for x in p["center"]],
            :power  => p["exponent"],
            :direction => normalize([float(x) for x in p["direction"]])
        )
    end

    function nomalize{T<:AbstractFloat}(xs::Array{T,1})
        if norm(xs) < 1e-7
            return xs
        else
            return xs / norm(xs)
        end
    end


    function distance{T<:AbstractFloat}(point::Array{T,1}, p::Dict)
        v = point - p[:center]
        return norm(v - dot(v, p[:direction])*p[:direction])
    end

    function value{T<:AbstractFloat}(coordinates::Array{T,1}, p::Dict)
        d = distance(coordinates, p)
        if d >= p[:radius]
            return 0.0
        else
            # the center should have the highest energy
            return 0.5 * p[:k] * (d - p[:radius])^p[:power]
        end
    end

    function compute_aux{T<:AbstractFloat}(coordinates::Array{T,1}, param_list::Array, accum::AbstractFloat)
        if length(param_list) == 0
            return accum
        else
            return compute_aux(coordinates, param_list[2:end], accum + value(coordinates, param_list[1]))
        end
    end

    function fn_compute(coordinates)
        return compute_aux(coordinates, [parseParam(p) for p in params], 0.0)
    end

    return fn_compute
end

export get_fn
end

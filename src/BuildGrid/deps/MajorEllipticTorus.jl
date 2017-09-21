"""
Produce an elliptic torus with circular tube cross 
section
"""
module MajorEllipticTorus


# minimum distance between a point and ellipse
function min_distance(a, b, coordinates)
    x = abs(coordinates[1])
    y = abs(coordinates[2])
    z = coordinates[3]
    function aux(phi, accum)
        new_phi = atan(((a^2 - b^2)*sin(phi) + y*b)/(x*a))
        if abs(phi - new_phi) < 1e-4
            return new_phi
        else
            return aux(new_phi, accum+1)
        end
    end
    phi = aux(0, 0)
    return sqrt(z^2 + (x - a * cos(phi))^2 + (y - b*sin(phi))^2)
end

# check whether a point is inside the torus

function get_fn(argd::Dict)
    a = float(argd["major"]["a"])
    b = float(argd["major"]["b"])
    r = float(argd["minor"]["radius"])
    center = [float(x) for x in argd["center"]]
    force_constant = float(argd["k"])

    function fn_compute(raw_coordinates)
        coordinates = raw_coordinates - center 
        if norm(coordinates[1:2]) < 1e-6
            d = sqrt(min(a,b)^2 + coordinates[3]^2)
        else
            d = min_distance(a, b, coordinates)
        end
        if d < r
            return 0
        else
            return force_constant * d
        end
    end
    return fn_compute
end

export get_fn

end
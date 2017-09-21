"""
Produce an elliptic tube shape with zero potential inside
"""
module EllipticTube


# minimum distance between a point and ellipse (X-Y plane)
# note: the original algorithm only works for ellipse with
# major axis aligned to x-axis
# This is why I need to check whether a < b,
# and make a rotation by -90 degrees.
function min_distance_2d(a, b, coordinates)
    if a < b
        return min_distance_2d(b, a, [coordinates[2], -coordinates[1]])
    end
    x = abs(coordinates[1])
    y = abs(coordinates[2])
    function aux(phi, accum)
        new_phi = atan(((a^2 - b^2)*sin(phi) + y*b)/(x*a))
        if abs(phi - new_phi) < 1e-4
            return new_phi
        else
            return aux(new_phi, accum+1)
        end
    end
    phi = aux(0, 0)
    return sqrt((x - a * cos(phi))^2 + (y - b*sin(phi))^2)
end

function isInside(a, b, xy)
    x, y = xy
    return (x^2/(a^2) + y^2/(b^2) < 1.0)
end

# check whether a point is inside the torus

function get_fn(argd::Dict)
    major_a = float(argd["major"]["a"])
    major_b = float(argd["major"]["b"])
    center = [float(x) for x in argd["center"]]
    power = convert(Int, argd["power"])
    force_constant = float(argd["k"])

    function fn_compute(raw_coordinates)
        coordinates = raw_coordinates - center 
        if norm(coordinates[1:2]) < 1e-6
            d_xy = min(major_a, major_b)
        else
            d_xy = min_distance_2d(major_a, major_b, coordinates[1:2])
        end
        
        if isInside(major_a, major_b, coordinates[1:2])
            return 0.0
        else
            return (1.0/power) * force_constant * (d_xy^power)
        end
    end
    return fn_compute
end

export get_fn

end
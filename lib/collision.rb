module Collision
  ELASTICITY = 1

  def collided?(vessel1, vessel2)
    dx = vessel1.position[0] - vessel2.position[0]
    dy = vessel1.position[1] - vessel2.position[1]
    distance = Math.sqrt(dx*dx + dy*dy)
    distance <= (vessel1.radius + vessel2.radius)
  end

  def collide(vessel1, vessel2)
    normal = (vessel1.position_vector - vessel2.position_vector)
    normal *= (1 / normal.r)
    p = dot_product(vessel1.velocity_vector, normal) - dot_product(vessel2.velocity_vector, normal)
    vessel1.velocity = vessel1.velocity_vector - normal * p
    vessel2.velocity = vessel2.velocity_vector + normal * p
  end

  def angle_between(u, v)
    w = u - v
    Math.acos(((u.r * u.r + v.r*v.r - w.r * w.r) / (2 * u.r * v.r)).to_f)
  end
  
  def dot_product(l1, l2)
    sum = 0
    for i in 0...l1.size
      sum += l1[i] * l2[i]
    end
    sum
  end

end
import mlx.core as mx

x = mx.array([1.0, 2.0, 3.0])  # Proper initialization as an MLX array

world = mx.distributed.init()

print("Distributed world size:", world.size())
print("Current rank:", world.rank())

if world.size() > 1:
    x = mx.distributed.all_sum(x)

print("Result after all_sum:", x)
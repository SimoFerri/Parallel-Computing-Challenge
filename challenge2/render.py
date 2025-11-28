import sys
import struct
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors

def load_grid_binary(filename):
  with open(filename, "rb") as f:
    W = struct.unpack("<i", f.read(4))[0]
    H = struct.unpack("<i", f.read(4))[0]
    N = W * H
    alive = np.frombuffer(f.read(N * 1), dtype=np.uint8)
    hue = np.frombuffer(f.read(N * 4), dtype=np.float32)
  return W, H, alive.reshape(H, W), hue.reshape(H, W)

def hue_to_rgb(hue):
  hsv = np.zeros(hue.shape + (3,), dtype = float)
  hsv[..., 0] = hue
  hsv[..., 1] = 1.0 # full saturation
  hsv[..., 2] = 1.0 # full value
  return mcolors.hsv_to_rgb(hsv)

def render(filename):
  W, H, alive, hue = load_grid_binary(filename)
  rgb = hue_to_rgb(hue)
  rgb[alive == 0] = 0.0

  plt.figure(figsize=(10,10))
  plt.imshow(rgb, interpolation = "nearest")
  plt.title(f"{filename} ({W} × {H})")
  plt.axis("off")
  plt.show()

render("final_grid.temp")

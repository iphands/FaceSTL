from stl_tools import numpy2stl
from scipy.misc import lena, imresize
from scipy.ndimage import gaussian_filter
from pylab import imread
import sys

file_name = str(sys.argv[1])
scale_fl = float(sys.argv[2])
blur_fl = float(sys.argv[3])

img = 350 * imread("./.tmp.img.png")
img = img[:, :, 2] + 1.0*img[:,:, 0] # Compose RGBimg channels to give depth
img = gaussian_filter(img, blur_fl)  # smoothing
numpy2stl(img, file_name, scale=scale_fl, solid=True)

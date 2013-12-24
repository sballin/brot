#!/usr/bin/env python

import sys
import time
import argparse
import math
import numpy as np
from PIL import Image
import plotdata

startTime = time.time()

parser = argparse.ArgumentParser()

parser.add_argument('-s', '--step', dest='step', type=float, metavar='F', 
                    help='step size', default=0.005)
parser.add_argument('-i', '--iterations', dest='maxits', type=int, metavar='N',
                    help='maximum number of iterations', default=2000)
parser.add_argument('-o', '--output', dest='filename', metavar='NAME',
                    help='name of output file', default='mandelbrot')

args = parser.parse_args()

window = [-2.1, 1.1, -1.4, 1.4]
[xmin, xmax, ymin, ymax] = window

abslim = 2

data = plotdata.rgbData(window, args.step, args.maxits, abslim)

x = len(plotdata.drange(xmin, xmax, args.step))
y = len(plotdata.drange(ymin, ymax, args.step))

im = Image.new('RGB', (x,y))
im.putdata(data)
im.format = 'PNG'
saveName = args.filename + '.png'
im.save(saveName)
print 'Output to ' + saveName 

im.show()

endTime = time.time()
elapsed = endTime-startTime
sys.stdout.write("%.2f seconds elapsed.\n" % elapsed)


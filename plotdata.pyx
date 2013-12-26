import sys
import math
import colorsys

def drange(start, stop, step):
    r = []
    rmax = start
    while rmax < stop:
        r.append(rmax)
        rmax += step
    return r

def palette(hue, its, maxits):
    rgbNorm = colorsys.hsv_to_rgb(hue, 1.0, 1.0)
    rgbFloat = tuple([255*v for v in rgbNorm])
    rgb = tuple([int(v) for v in rgbFloat])
    if its == maxits:
        rgb = (0, 0, 0)
    return rgb

def isInCardioidOrBulb(x, y):
    p = math.sqrt((x-0.25)*(x-0.25)+y*y)
    if x < p-2*p*p+0.25 or (x+1)*(x+1)+y*y < 0.0625:
        return True
    else:
        return False

def rgbData(window, step, maxits, abslim):
    [xmin, xmax, ymin, ymax] = window

    pixels = []

    histogram = range(maxits+1)
    for i in histogram:
        histogram[i] = 0
    total = 0

    yrange = drange(ymin, ymax, step)
    xrange = drange(xmin, xmax, step)
    ysize = len(yrange)

    percentages = list([float(i)/10 for i in range(1, 10)])
    checkpoints = list([int(ysize*i) for i in percentages])
    counter = 0

    for y in yrange:
        for x in xrange:
            c = complex(x,y)

            z     = 0
            zprev = 0
            its   = 0

            if isInCardioidOrBulb(x, y):
                its = maxits
            else:
                while abs(z) < abslim and its < maxits:
                    z     = zprev*zprev+c
                    zprev = z
                    its  += 1

            histogram[its] += 1
            total += 1

            pixels.append(its)

        counter += 1
        for checkpoint in checkpoints:
            if counter == checkpoint:
                progress = str(int(100*counter/ysize+1))
                print progress + '%'

    print 'Rendering...'

    for i in range(len(pixels)):
            hue = pixels[i]*histogram[pixels[i]]/float(total)
            pixels[i] = palette(hue, pixels[i], maxits)

    return pixels

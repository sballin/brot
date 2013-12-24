#!/usr/bin/env python

from distutils.core import setup
from Cython.Build import cythonize

setup(
  name = 'Plotdata',
  ext_modules = cythonize("plotdata.pyx"),
)

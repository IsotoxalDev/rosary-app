#!/usr/bin/env python3

import os

ext = ".jpg"

for i in range(1, 6):
    filename = f"sorrow{i}"
    to = f"SORROW{i}"
    os.system(f"mv {filename + ext} {to + ext}")

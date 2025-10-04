import sys
import subprocess
from pathlib import Path
import cv2 as cv

directory = Path(sys.argv[1])
output = Path("blurryimages.txt")

for file in directory.iterdir():
    image = cv.imread(str(file))
    grayscale = cv.cvtColor(image, cv.COLOR_BGR2GRAY)
    laplacian = cv.Laplacian(grayscale, cv.CV_64F).var()
    if laplacian<50:
        subprocess.run(["notify-send", "Out of focus image(s) detected: paths saved to file."])
        with open(output, "a") as f:
            f.write(str(file.resolve()) + "\n")

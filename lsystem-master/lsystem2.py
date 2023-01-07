import sys, json, getopt
import tkinter as tk
from lsys import LSystemVisualiser, LGrammar

width = 640
height = 480

master = tk.Tk()
master.geometry("%dx%d%+d%+d" % (width, height, 0, 0))
canvas = tk.Canvas(master, width=width, height=height)
canvas.pack()

# Mango Leaf
#axiom="Y---Y"
#rules={"X": "F-FF-F--[--X]F-FF-F--F-FF-F--", "Y": "f-F+X+F-fY"}
#iters=10
#angle=60
#length=2

# von Koch - islands and lakes
#axiom="F+F+F+F"
#rules={"F": "F+f-FF+F+FF+Ff+FF-f+FF-F-FF-Ff-FFF", "f": "ffffff"}
#iters=2
#angle=90
#length=2

# von Koch - acute snowflake
#axiom="F+(120)F+(120)F"
#rules={"F": "F-F++F-F"}
#iters=4
#angle=75
#length=2

# 2D bush #9
#axiom="G"
#rules={"G": "GfX[+G][-G]", "X": "X[-FFF][+FFF]FX"}
#iters=5
#angle=25.71
#length=2

# Snake Kolam
#axiom="F+XF+F+XF"
#rules={"X": "XF-F-F+XF+F+XF-F-F+X"}
#iters=4
#angle=90
#length=2

# L-System algae Written by Paul Bourke
#axiom="aF"
#rules={"a": "FFFFFv[+++h][---q]fb", "b": "FFFFFv[+++h][---q]fc","c":"FFFFFv[+++fa]fd","d":"FFFFFv[+++h][---q]fe","e":"FFFFFv[+++h][---q]fg","g":"FFFFFv[---fa]fa","h":"ifFF","i":"fFFF[--m]j","j":"fFFF[--n]k","k":"fFFF[--o]l","l":"fFFF[--p]","m":"fFn","n":"fFo","o":"fFp","p":"fF","q":"rfF","r":"fFFF[++m]s","s":"fFFF[++n]t","t":"fFFF[++o]u","u":"fFFF[++p]","v":"Fv"}
#iters=20
#angle=12
#length=2

# Fudge Flake #1
#axiom="F"
#rules={"F": "+F++D|F++D|F|D+", "D": ">(1.73205)D<(1.73205)"}
#rules={"F": "+F++D|F++D|F|D+", "D": ">D<"}
#iters=7
#angle=30
#length=2

# peano gosper curve #1
#axiom="FX"
#rules={"X": "X+YF++YF-FX--FXFX-YF+", "Y": "-FX+YFYF++YF+FX--FX-Y"}
#iters=4
#angle=60
#length=2

# segments #1
#axiom="FB"
#rules={"A": "FBFA+HFA+FB-FA", "B": "FB+FA-FB-JFBFA", "H": "-", "J": "+", "F": ""}
#iters=5
#angle=90
#length=2

# Cesaro curve #1
axiom="F+(172)F+(172)F+(172)F"
rules={"F": "F+F--F+F"}
iters=5
angle=85.25
length=2

# Tree
#axiom="X"
#rules={"F": "FF", "X": "F-[[X]+X]+F[+FX]-X"}
#iters=6
#angle=22.5
#length=2

try:
    grammar = LGrammar(rules)
    lvis = LSystemVisualiser(canvas, angle,grammar.generate(axiom,iters),length)
    lvis.draw()
except ValueError as err:
    sys.stderr.write("Error: " + str(err) + "\n")
    sys.exit(1)

master.update()    
tk.mainloop()
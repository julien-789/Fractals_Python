import sys, json, getopt
import tkinter as tk
from lsys import LSystemVisualiser, LGrammar

width = 640
height = 480

master = tk.Tk()
master.geometry("%dx%d%+d%+d" % (width, height, 0, 0))
canvas = tk.Canvas(master, width=width, height=height)
canvas.pack()

# P. Bourke after Saupe
#axiom="VZFFF"
#rules={"V": "[+++W][---W]YV","W":"+X[-W]Z","X":"-W[+X]Z","Y":"YZ","Z":"[-FcFF][+FdFF]F","c":"","d":""}
#iters=8
#angle=20
#length=2

# poetasters succulent 1
#axiom="A"
#rules={"A": "[FL]gAhg[FLA]","F":"cSF","S":"dFL","L":"c[F+F+F]fe[F-F-F]","c":"","d":"","e":"","g":"","h":""}
#iters=7
#angle=17
#length=2

# Weed, P. Bourke
#axiom="F"
#rules={"F": "FF-[XY]+[XY]","X":"+cFY","Y":"-dFX","c":"","d":""}
#iters=6
#angle=22.5
#length=2

# Pean-c flower after Gary Teachout
#axiom="FXhFXiFX"
#rules={"F": "","X":"[FX-FY][-cFX-FY-FX][ZZ]-dFY-FX+FY+FX","Y":"FY","Z":"-cFX-FY-FX","c":"","d":"","h":"","i":""}
#iters=3
#angle=340
#length=2

# poetasters weed, after, P. Bourke
#axiom="F"
#rules={"F": "F-[XY]+[XY]F+[XY]-[XY]","X":"+dFY","Y":"-cFX","c":"","d":""}
#iters=6
#angle=22.5
#length=2

# Unlikely bush (after Bourke)
#axiom="F"
#rules={"F": "eF[+cFF][-FF]cF[-F]d[+F]F","c":"","d":"","e":""}
#iters=3
#angle=330
#length=2

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
#rules={"F": "+F++D|F++D|F|D+", "D": ">(181.73205)D<(181.73205)"}
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
#axiom="F+(90)F+(90)F+(90)F"
#rules={"F": "F+F--F+F"}
#iters=5
#angle=85.3
#length=2

# Tree
#axiom="X"
#rules={"F": "FF", "X": "F-[[X]+X]+F[+FX]-X"}
#iters=6
#angle=22.5
#length=2

# Wheel
#axiom="WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
#rules={"W": "[X]+", "X": "[+++++++++++++Y[X]]-------------Y[X]", "Y": "YFYF"}
#iters=8
#angle=5
#length=2

# Tree 2
#axiom="FFFFFFX"
#rules={"F": "F", "X": "FFF-[-F+F[Y]-[X]]+[+F+F[X]-[X]]", "Y": "FF-[-F+F]+[+F+FY]"}
#iters=6
#angle=15
#length=2


# Python program to demonstrate
# command line arguments
 
import argparse
 
 
# Initialize parser
parser = argparse.ArgumentParser()
 
# Adding optional argument
#parser.add_argument("-px", "--Penx", help = "Pen x in pixels")
#parser.add_argument("-py", "--Peny", help = "Pen y in pixels")
parser.add_argument("-ang", "--Angle", help = "Angle in degrees")
#parser.add_argument("-ptx", "--Pointx", help = "Point x in pixels")
#parser.add_argument("-pty", "--Pointy", help = "Point y in pixels")
#parser.add_argument("-a", "--Axiom", help = "Axiom")
#parser.add_argument("-p1", "--Production1", help = "Production 1")
#parser.add_argument("-r1", "--Rule1", help = "Mapping rule 1")
#parser.add_argument("-p2", "--Production2", help = "Production 2")
#parser.add_argument("-r2", "--Rule2", help = "Mapping rule 2")
#parser.add_argument("-p3", "--Production3", help = "Production 3")
#parser.add_argument("-r3", "--Rule3", help = "Mapping rule 3")
#parser.add_argument("-p4", "--Production4", help = "Production 4")
#parser.add_argument("-r4", "--Rule4", help = "Mapping rule 4")
#parser.add_argument("-p5", "--Production5", help = "Production 5")
#parser.add_argument("-r5", "--Rule5", help = "Mapping rule 5")
#parser.add_argument("-d", "--Delta", help = "Angular increments")
parser.add_argument("-i", "--Iterations", help = "Number of iterations")
parser.add_argument("-l", "--Length", help = "Initial line length")
#parser.add_argument("-r", "--Rate", help = "The multiplier of shrinking after each iteration")

# Read arguments from command line
args = parser.parse_args()

if args.Angle:
    angle=float(args.Angle)

if args.Length:
    # print("Displaying Output as: % s" % args.Axiom1)
    # print(args.Rule1)
    length=int(args.Length)
# else:
    # iterations=6

if args.Iterations:
    # print("Displaying Output as: % s" % args.Axiom1)
    # print(args.Rule1)
    iters=int(args.Iterations)
# else:
    # iterations=6

# Using readlines()
file1 = open("axiom.txt", 'r')
Lines = file1.readlines()
#production1 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    line=line.replace('\n','')
    axiom=line.strip()
file1.close()

# Using readlines()
file1 = open("production1.txt", 'r')
Lines = file1.readlines()
#production1 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    line=line.replace('\n','')
    production1=line.strip()
file1.close()

# Using readlines()
file1 = open("rule1.txt", 'r')
Lines = file1.readlines()
#fracrule1 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    line=line.replace('\n','')
    fracrule1=line.strip()
file1.close()

# Using readlines()
file1 = open("production2.txt", 'r')
Lines = file1.readlines()
#production2 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    line=line.replace('\n','')
    production2=line.strip()
file1.close()

# Using readlines()
file1 = open("rule2.txt", 'r')
Lines = file1.readlines()
#fracrule2 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    line=line.replace('\n','')
    fracrule2=line.strip()
file1.close()

# Using readlines()
file1 = open("production3.txt", 'r')
Lines = file1.readlines()
#production3 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    production3=line.strip()
file1.close()

# Using readlines()
file1 = open("rule3.txt", 'r')
Lines = file1.readlines()
#fracrule3 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    fracrule3=line.strip()
file1.close()

# Using readlines()
file1 = open("production4.txt", 'r')
Lines = file1.readlines()
#production4 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    production4=line.strip()
file1.close()

# Using readlines()
file1 = open("rule4.txt", 'r')
Lines = file1.readlines()
#fracrule4 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    fracrule4=line.strip()
file1.close()

# Using readlines()
file1 = open("production5.txt", 'r')
Lines = file1.readlines()
#production5 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    production5=line.strip()
file1.close()

# Using readlines()
file1 = open("rule5.txt", 'r')
Lines = file1.readlines()
#fracrule5 = []
count = 0
# Strips the newline character
for line in Lines:
    count += 1
    fracrule5=line.strip()
file1.close()

rules={production1: fracrule1,production2: fracrule2, production3: fracrule3, production4: fracrule4, production5: fracrule5}

f= open("test.csv","w")
f.close()

try:
    grammar = LGrammar(rules)
    lvis = LSystemVisualiser(canvas, angle,grammar.generate(axiom,iters),length)
    lvis.draw()
except ValueError as err:
    sys.stderr.write("Error: " + str(err) + "\n")
    sys.exit(1)

master.update()    
tk.mainloop()
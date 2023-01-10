lsystem
=======

Simple [L-system](http://en.wikipedia.org/wiki/Lsystem) based fractal generator written just for fun.

Alphabet that can be used in axioms and rules is pretty simple: *FGf+-[]*. Each letter is responsible for particular
turtle (see [turtle graphics](http://en.wikipedia.org/wiki/Turtle_graphics) for more info) command, namely:

Usage:

Run draw_from_file App

Click on Parameters to edit your L-system

Click on Draw to draw the fractal

Requires Python 3.8 32-bit for Windows

https://www.python.org/ftp/python/3.8.0/python-3.8.0.exe

* *F* and *G*: draw forward
* *f*: move cursor forward without drawing anything
* *+*: turn right
* *-*: turn left
* *[*: push current state of the cursor into the stack
* *]*: pop state of the cursor from the stack
* ...

Example of valid L-system parameters:

# von Koch - acute snowflake

axiom="F+(120)F+(120)F"

rules={"F": "F-F++F-F"}

iters=4

angle=75

# Cesaro curve #1

axiom="F+(90)F+(90)F+(90)F"

rules={"F": "F+F--F+F"}

iters=5

angle=85.3

# Mango Leaf

axiom="Y---Y"

rules={"X": "F-FF-F--[--X]F-FF-F--F-FF-F--", "Y": "f-F+X+F-fY"}

iters=10

angle=60

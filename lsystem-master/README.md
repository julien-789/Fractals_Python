lsystem
=======

Simple [L-system](http://en.wikipedia.org/wiki/Lsystem) based fractal generator written just for fun.

Alphabet that can be used in axioms and rules is pretty simple: *FGf+-[]*. Each letter is responsible for particular
turtle (see [turtle graphics](http://en.wikipedia.org/wiki/Turtle_graphics) for more info) command, namely:

Usage:

Run draw_from_file App
Click on Parameters to edit your L-system
Click on Draw to draw the fractal

Requires Python 3.8 32-bit

* *F* and *G*: draw forward
* *f*: move cursor forward without drawing anything
* *+*: turn right
* *-*: turn left
* *[*: push current state of the cursor into the stack
* *]*: pop state of the cursor from the stack
* ...

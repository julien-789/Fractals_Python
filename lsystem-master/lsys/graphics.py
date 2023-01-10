import math
from lsys.core import LToken, LStringParser


class Cursor(object):
    def __init__(self,  canvas, steplen=2, angle=270):
        self._canvas = canvas
        self._pen_color = "black"
        self._steplen = steplen
        self._x = self._y = self._cang = 0
        self._init_angle = angle % 360
        self.reset()

    def reset(self):
        #self._x = int(self._canvas.cget("width")) / 2
        #self._y = int(self._canvas.cget("height")) / 2
        self._x = 0
        self._y = 0
        self._cang = self._init_angle

    def get_coords(self):
        return (self._x, self._y)

    def set_coords(self, coords):
        (self._x, self._y) = coords

    def get_steplen(self):
        return self._steplen

    def set_steplen(self, steplen):
        self._steplen = steplen

    def set_steplenmultandmove(self, steplen):
        self._steplen = self._steplen*steplen
        (nx, ny) = self._inspect(1)
        self._canvas.create_line(self._x, self._y, nx, ny)
        (self._x, self._y) = (nx, ny)

    def set_steplendivandmove(self, steplen):
        self._steplen = self._steplen/steplen
        (nx, ny) = self._inspect(1)
        self._canvas.create_line(self._x, self._y, nx, ny)
        (self._x, self._y) = (nx, ny)

    def set_angle(self, angle):
        self._angle = angle

    def save_state(self):
        return (self._x, self._y, self._cang,
                self._pen_color)

    def restore_state(self, state):
        (self._x, self._y, self._cang,
         self._pen_color) = state

    def move(self, steps):
        (self._x, self._y) = self._inspect(steps)

    def draw(self, steps):
        (nx, ny) = self._inspect(steps)
        self._canvas.create_line(self._x, self._y, nx, ny)
        f= open("test.csv","a")
        writestr=str(self._x)+","+str(self._y)
        f.write(writestr+'\n')
        writestr=str(nx)+","+str(ny)
        f.write(writestr+'\n')
        f.close()
        (self._x, self._y) = (nx, ny)

    def turn_left(self, angle):
        self._add_angle(-angle)

    def turn_right(self, angle):
        self._add_angle(angle)

    def turn_around(self):
        self._add_angle(-180)
	  

    def _inspect(self, steps):
        length = steps * self._steplen
        angle_rads = math.radians(self._cang)
        return [i[1] + i[0] * length for i in 
            zip((math.cos(angle_rads), math.sin(angle_rads)),
                (self._x, self._y))]

    def _add_angle(self, angle):
        self._cang += angle
        self._cang %= 360

    def _set_angle(self, angle):
        self._cang = angle
        self._cang %= 360

    def do_nothing(self):
        return 0    

class LSystemVisualiser(object):
    def __init__(self, canvas, angle, lstring, steplen):
        self._cursor = Cursor(canvas,steplen)
        self._canvas = canvas
        self._parser = LStringParser(lstring)
        self._angle = angle
        self._steplen = steplen
        self._stack = []
        self._stack2 = ()
        self._table = {
            LToken.DRAW: lambda: self._cursor.draw(1),
            LToken.FORWARD: lambda: self._cursor.move(1),
            LToken.TLEFT: lambda: self._cursor.turn_left(self._angle),
            LToken.TRIGHT: lambda: self._cursor.turn_right(self._angle),
            LToken.PUSH: lambda: self._stack.append(self._cursor.save_state()),
            LToken.POP: lambda: self._cursor.restore_state(self._stack.pop()),
            LToken.AROUND: lambda: self._cursor.turn_around(),
            LToken.MULTIPLYLENGTH: lambda: self._cursor.set_steplenmultandmove(1.1),
            LToken.DIVIDELENGTH: lambda: self._cursor.set_steplendivandmove(1.1),
            LToken.MULTIPLYROTATION: lambda: self._cursor.set_angle(self._angle*1.1),
            LToken.DIVIDEROTATION: lambda: self._cursor.set_angle(self._angle/1.1),
            LToken.PUSHROTATEBY: lambda: self.getnumber(lstring),
            LToken.POPROTATEBY: lambda: self._cursor.do_nothing(),
		LToken.ZERO: lambda: self._cursor.do_nothing(),
		LToken.ONE: lambda: self._cursor.do_nothing(),
		LToken.TWO: lambda: self._cursor.do_nothing(),
            LToken.THREE: lambda: self._cursor.do_nothing(),
            LToken.FOUR: lambda: self._cursor.do_nothing(),
            LToken.FIVE: lambda: self._cursor.do_nothing(),
            LToken.SIX: lambda: self._cursor.do_nothing(),
            LToken.SEVEN: lambda: self._cursor.do_nothing(),
            LToken.EIGHT: lambda: self._cursor.do_nothing(),
            LToken.NINE: lambda: self._cursor.do_nothing(),
            LToken.POINT: lambda: self._cursor.do_nothing()
        }

    def getnumber(self,lstring):        
        token = self._parser.current_token()      
        x = 0
        numberstr=""
        while x==0:            
            numberstr=numberstr+lstring[token]
            token += 1                       
            if lstring[token]==")":
                x = 1              
        self._cursor.turn_right(self._angle-float(numberstr))

    def draw(self):
        # get the coordinates of the minimum rectangle 
        # that can be created around the the picture we're 
        # going to draw
        (xmin, xmax, ymin, ymax) = self._get_picture_rect()

        # now, when we know the size of this rectangle,
        # we can try to enlarge it (so as the picture)
        # and fit it to the available area in the best
        # way.
        xlen = xmax - xmin
        ylen = ymax - ymin
        width = int(self._canvas.cget("width"))
        height = int(self._canvas.cget("height"))
        diff = min(width - xlen, height - ylen) / 2        
        diff=0

        # adjust the step length
        old_slen = self._cursor.get_steplen()
        new_slen = old_slen + (old_slen * diff) / xlen
        self._cursor.set_steplen(new_slen)

        # adjust the coordinates so that picture will be
        # centered when drawn
        (x, y) = self._cursor.get_coords()
        #nxmin = (width / 2) - (xlen / old_slen * new_slen) / 2
        #nymin = (height / 2) - (ylen / old_slen * new_slen) / 2
        #self._cursor.set_coords(((x - xmin) / old_slen * new_slen + nxmin,
        #                        (y - ymin) / old_slen * new_slen + nymin))
        self._cursor.set_coords(((x) / old_slen * new_slen,
                                 (y) / old_slen * new_slen))

        # and draw it, finally
        token = self._parser.first_token()
        while token:
            self._process_token(token)
            token = self._parser.next_token()
        exit()

    def _get_picture_rect(self):
        (x, y) = self._cursor.get_coords()
        (xmin, xmax) = (x - 1, x + 1)
        (ymin, ymax) = (y - 1, y + 1)

        token = self._parser.first_token()
        while token:
            self._process_token(token, dryrun=True)
            (x, y) = self._cursor.get_coords()
            xmin = min(x, xmin)
            xmax = max(x, xmax)
            ymin = min(y, ymin)
            ymax = max(y, ymax)
            token = self._parser.next_token()

        self._cursor.reset()
        return (xmin, xmax, ymin, ymax)

    def _process_token(self, token, dryrun=False):
        if dryrun and token == LToken.DRAW:
            token = LToken.FORWARD

        self._table[token]()

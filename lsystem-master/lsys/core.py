class LToken(object):
    DRAW = 1
    FORWARD = 2
    TLEFT = 3
    TRIGHT = 4
    PUSH = 5
    POP = 6
    AROUND = 7
    MULTIPLYLENGTH = 8
    DIVIDELENGTH = 9
    MULTIPLYROTATION = 10
    DIVIDEROTATION = 11
    PUSHROTATEBY = 12
    POPROTATEBY = 13
    ZERO = 14
    ONE = 15
    TWO = 16
    THREE = 17
    FOUR = 18
    FIVE = 19
    SIX = 20
    SEVEN = 21
    EIGHT = 22
    NINE = 23
    POINT = 24

class LStringParser(object):
    CONSTS = {
        'F': LToken.DRAW,
        'G': LToken.DRAW,
        'f': LToken.FORWARD,
        '+': LToken.TLEFT,
        '-': LToken.TRIGHT,
        '[': LToken.PUSH,
        ']': LToken.POP,
        '|': LToken.AROUND,
        '>': LToken.MULTIPLYLENGTH,
        '<': LToken.DIVIDELENGTH,
        ';': LToken.MULTIPLYROTATION,
        ',': LToken.DIVIDEROTATION,
        '(': LToken.PUSHROTATEBY,
        ')': LToken.POPROTATEBY,
        '0': LToken.ZERO,
        '1': LToken.ONE,
        '2': LToken.TWO,
        '3': LToken.THREE,
        '4': LToken.FOUR,
        '5': LToken.FIVE,
        '6': LToken.SIX,
        '7': LToken.SEVEN,
        '8': LToken.EIGHT,
        '9': LToken.NINE,
        '.': LToken.POINT
    }

    def __init__(self, lstr):
        self._lstr = lstr
        self._pos = -1

    def first_token(self):
        self._pos = 0
        return self.next_token()

    def current_token(self):
        #return self._lstr[self._pos]
        return self._pos

    def next_token(self):
        while self._pos < len(self._lstr):
            sym = self._lstr[self._pos]
            self._pos += 1
            if sym in self.CONSTS.keys():
                return self.CONSTS[sym]

        return None

    
class LGrammar(object):
    def __init__(self, rules):
        self._rules = rules
        self._alphabet = set(rules.keys() | LStringParser.CONSTS.keys())
        for val in self._rules.values():
            self._validate_lstring(val)

    def generate(self, axiom, iters):
        self._validate_lstring(axiom)
        lstr = axiom
        for i in range(iters):
            lstr = self._apply_rules(lstr)

        return lstr

    def _apply_rules(self, lstr):
        res = ""
        for c in lstr:
            if c in self._rules.keys():
                res += self._rules[c]
            else:
                res += c

        return res

    def _validate_lstring(self, value):
        for sym in value:
            if sym not in self._alphabet:
                raise ValueError("'%s' is neither a constant nor variable" % sym)
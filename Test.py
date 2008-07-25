from antlr3 import *;
from antlr3.tree import *;
import Eval
import ExprLexer
import ExprParser
import sys

import unittest

def evaluate(value):
    input = ANTLRStringStream(value)
    lexer = ExprLexer.ExprLexer(input);
    tokens = CommonTokenStream(lexer);
    parser = ExprParser.ExprParser(tokens);
    r = parser.prog();
    t = r.tree; # // get tree from parser
    nodes = CommonTreeNodeStream(t);
    walker = Eval.Eval(nodes);  # // create a tree parser
    return walker.prog()


class testcase(unittest.TestCase):
    def testSumaSimple(self):
        answer = evaluate("""x=2
2+x
""")
        self.assertEqual(4,answer.pop())

    def testOperacion(self):
        answer = evaluate("""x=2*5+10
(x*x)+x
""")
        self.assertEqual(420,answer.pop())

    def testEspacioBlanco(self):
        answer = evaluate("""x= 2 * 5+ 10
(x*x)+x
""")
        self.assertEqual(420,answer.pop())
        

if __name__ == "__main__" and len(sys.argv) < 2:
    unittest.main()
else:
    print str(sys.argv[1])
    print evaluate(str(sys.argv[1] + "\n"))

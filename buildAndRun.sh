#!/bin/bash

echo Cleaning directories
rm -f Eval.py *.pyc Eval.tokens Expr.tokens ExprLexer.py ExprParser.py
cd antlr3
rm -f *.pyc
cd ..

echo Inboking ANTLR
java -cp antlrworks-1.1.7.jar org.antlr.Tool Expr.g
java -cp antlrworks-1.1.7.jar org.antlr.Tool Eval.g

echo Run UnitTest
python Test.py

echo Make a Sample 
python Test.py "2+22+4"

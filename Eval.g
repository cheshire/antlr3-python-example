tree grammar Eval;

options {
    tokenVocab=Expr;
    ASTLabelType=CommonTree;
	language=Python;
}

// START:members
@members {
    global memory, result
    memory = dict()
    result = list()
}
// END:members

// START:stat
prog:   stat+ { return result};

stat:   expr {
            print $expr.value
            result.append($expr.value)
                }
    |   ^('=' ID expr) {
            memory[$ID.getText()] = int($expr.value)
                }
    ;
// END:stat

// START:expr
expr returns [int value]
    :   ^('+' a=expr b=expr) {$value = a+b;}
    |   ^('-' a=expr b=expr) {$value = a-b;}   
    |   ^('*' a=expr b=expr) {$value = a*b;}
    |   ID {
            value = memory.copy().pop($ID.getText());
        }
    |   INT {
            $value = int(str($INT));
        }
    ;
// END:expr


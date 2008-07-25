grammar Expr;
options {
    output=AST;
    ASTLabelType=CommonTree; // type of $stat.tree ref etc...
    language=Python;

}

// START:stat
/** Match a series of stat rules and, for each one, print out
 *  the tree stat returns, $stat.tree.  toStringTree() prints
 *  the tree out in form: (root child1 ... childN)
 *  ANTLR's default tree construction mechanism will build a list
 *  (flat tree) of the stat result trees.  This tree will be the input
 *  to the tree parser.
 */
prog:   ( stat { print $stat.tree.toStringTree() } )+ ;

stat:   expr NEWLINE        -> expr
    |   ID '=' expr NEWLINE -> ^('=' ID expr)
    |   NEWLINE             ->
    ;
// END:stat

// START:expr
expr:   multExpr (('+'^|'-'^) multExpr)*
    ; 

multExpr
    :   atom ('*'^ atom)*
    ; 

atom:   INT 
    |   ID
    |   '('! expr ')'!
    ;
// END:expr

// START:tokens
ID  :   ('a'..'z'|'A'..'Z')+ ;
INT :   '0'..'9'+ ;
NEWLINE:'\r'? '\n' ;
WS  :   (' '|'\t'|'\n'|'\r')+ {$channel = HIDDEN;};
// END:tokens

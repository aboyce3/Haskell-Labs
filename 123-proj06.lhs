
-------------------------------------------------------------------------------

Spring 2022  CIS 623    Project 6

-------------------------------------------------------------------------------

> import Data.List (nub)
> import Set
> import Test.QuickCheck


-------------------------------------------------------------------------------

IMPORTANT NOTE:

It is expected taht your submission can be loaded to the GHCi interpreter
successfully. The grader will deduce points if your submission fails to do so.

** Total point: 15 + 60 + 181 = 251 point **

-------------------------------------------------------------------------------

(10 point) Fill in the following information. You will lose 3 point for each
missing or incorrect answer.

Name: Andrew Boyce
SU email: amboyce@syr.edu
Number: 123

ie. The 3 digit number assigned to you

-------------------------------------------------------------------------------

Due date:

Release:	Apr 04, 2022
Due date:	Apr 13, 2022, 11:59 pm

Remarks:

1. (5 point)

You submission should be named as XXX-proj6.lhs where XXX is the 3 digit no.
assigned to you in blackboard

You will lose 5 point if you do not following this naming convention.

2. We do not accept any late submissions.
3. If you encounter any difficulties, but you can upload your submission
   within an hour after the due date, please state the reason below:

State the reason(s) for late submission below (if needed):

4. If you cannot upload your submission within an hour after the due date
   because of a valid reason (eg. network/power outage etc.)  contact the
   grader at tjiang15@syr.edu when email is available. Your grader will not
   grade your work but you may receive an exemption.

--------------------------------------------------------------------------------

This project is a follow up to the previous project where you were asked
to implement a datatype Form which represents the access control formulas
given in ACST chapter2 .

For this project, we will use the following definitions for the data types
Form and Prin (below) to represent ACL formulas:

> data Form  = Var   Char
>            | Not   Form
>            | Or    Form Form
>            | And   Form Form
>            | Imply Form Form
>            | Equiv Form Form
>            | Says  Prin Form
>            | Contr Prin Form
>            | For   Prin Prin
>              deriving Show

> data Prin = Name String | Together Prin Prin | Quote Prin Prin
>              deriving (Show, Eq)


-------------------------------------------------------------------------------

Exercise 1  (Total: 40 + 20 = 60 point)

More on ACL formula

a. (40 point)  Write a function princount

prinCount :: Form -> Int

which will take an ACL formula f (of type Form) as input, counts the
number of single principals shown in f. For example, if:

> eg1 :: Form
> eg1 = (Says (Name "Di") (Var 's'))

> eg2 :: Form
> eg2 = (Says (Together (Name "Alice") (Name "Bob")) (Var 's'))

> eg3 :: Form
> eg3 = (Says (Together (Name "Alice") (Name "Alice")) (Var 's'))

then

*Main> prinCount eg1
1
*Main> prinCount eg2
2
*Main> prinCount eg3
1

Remarks:

1. You may like to develop helper functions when composing the
prinCount function.

2. The Set ADT given is to implement *ordered* sets. That is, the
elements in the set are ordered. You may not able to use the Set
data type in this question.

3. You may use the function nub from Data.List in this question.


*** Put your answer below. For codes, DO NOT FORGET to add the > symbol ***

> prinCount :: Form -> Int
> prinCount f = length (nub (prinHelper f))

> prinHelper :: Form -> [String]
> prinHelper (Var x)     = []
> prinHelper (Or x y)    = prinHelper x ++ prinHelper y
> prinHelper (And x y)   = prinHelper x ++ prinHelper y
> prinHelper (Not x)     = prinHelper x
> prinHelper (Imply x y) = prinHelper x ++ prinHelper y
> prinHelper (Equiv x y) = prinHelper x ++ prinHelper y
> prinHelper (For x y)   = countHelper x ++ countHelper y
> prinHelper (Says x y)  = countHelper x ++ prinHelper y
> prinHelper (Contr x y) = countHelper x ++ prinHelper y

> countHelper :: Prin -> [String]
> countHelper (Name x)       = [x]
> countHelper (Together x y) = countHelper x ++ countHelper y
> countHelper (Quote x y)    = countHelper x ++ countHelper y

-------------------------------------------------------------------------------


b.  (20 point)

Create 4 well-formed formulas

f1, f2, f3 and f4 where

-- f1 has no principals.

-- f2 is a formula which consists of principals only.

-- f3 has two single principals, each appears exactly once in the f3.

-- f4 has two single principals, each appears more than once in the f4.


Express f1, f2, f3 and f4 as data of type Form. Provide the expected answer
and the results of your test runs when computing prinCount in each of these
cases.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol ***

> f1 :: Form
> f1 = (Not (Var 's'))

*Main> prinCount f1
0

> f2 :: Form
> f2 = (For (Name "Bob") (Name "Alice"))

*Main> prinCount f2
2

> f3 :: Form
> f3 = (Contr (Together (Name "Alice") (Name "Bob")) (Var 'q'))

*Main> prinCount f3
2

> f4 :: Form
> f4 = (For (Together (Quote (Name "Bob") (Name "Alice")) (Name "Alice")) (Quote (Together (Name "Bob") (Name "Alice")) (Name "Bob")))

*Main> prinCount f4
2


-------------------------------------------------------------------------------

Exercise 2  (Total: 60 + 52 + 34 + 35 = 181 point)

 Implementation of the evaluation function (em) for ACL formulas

a. (60 point)

Following the following definitions given in ACST Chapter 2:

-  Definition 2.1 (page 23)
-  Definitions for J (P & Q), J (P | Q)  (page 27)
-  Figure 2.1     (page 29)


and the notations , representation introduced (see supplement 1)

implement the evaluation function em for ACL formulas:

em :: (WKripke, IKripke, JKripke) -> Form -> WKripke

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol ***

> type IKripke = Set (Char,Int)
> type WKripke = Set Int
> type JKripke = Set (String,(Int,Int))
> type PropVar = Set Char
> type PName   = Set Prin

> em :: (WKripke, IKripke, JKripke) -> Form -> WKripke
> em (_, y, _) (Var p)     = findI y p
> em (w, i, j) (Not p)     = diff w (em (w, i, j) p)
> em (w, i, j) (And x y)   = inter (em (w, i, j) x) (em (w, i, j) y)
> em (w, i, j) (Or x y)    = union (em (w, i, j) x) (em (w, i, j) y)
> em (w, i, j) (Imply x y) = union (diff w (em (w, i, j) x)) (em (w, i, j) y)
> em (w, i, j) (Equiv x y) = inter (em (w, i, j) (Imply x y)) (em (w, i, j) (Imply y x))
> em (w, i, j) (For x y)   | subSet (emPrin (w, i, j) y) (emPrin (w, i, j) x) = w
>                          | otherwise = empty
> em (w, i, j) (Says x y) = makeSet [w' | w' <- (flatten w), subSet (findJW (emPrin (w,i,j) x) w') (em (w,i,j) y)]
> em (w, i, j) (Contr x y) = (em (w,i,j) (Imply (Says x y) y))

> emPrin :: (WKripke, IKripke, JKripke) -> Prin -> JKripke
> emPrin (_, _, j) (Name x) = findJ j x
> emPrin (w, i, j) (Together x y) = union (emPrin (w, i, j) x) (emPrin (w, i, j) y)
> emPrin (w, i, j) (Quote x y) = compose (emPrin (w, i, j) x) (emPrin (w, i, j) y)

> compose :: JKripke -> JKripke -> JKripke
> compose a b = makeSet [(x,(y, z')) | (x, (y, z)) <- (flatten a), (x', (y', z')) <- (flatten b), z == y']

> findI :: IKripke -> Char -> WKripke
> findI i x = makeSet [y | (x', y) <- (flatten i), x' == x]

> findJ :: JKripke -> String -> JKripke
> findJ i x = makeSet [(x', y) | (x', y) <- (flatten i), x' == x]

> findJW :: JKripke -> Int -> WKripke
> findJW i w = makeSet [z | (x, (y, z)) <- (flatten i), y == w]

-------------------------------------------------------------------------------


b. Total 52 point
   (10 point (represent the model) + 42 point (14 test,  3 point each))

Exercise 2.3.2.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol ***

Please name the objects and test cases you created used with suffix "232":

eg. m232 = (w232, i232, j232), a232, b232 etc.

> printedForm232 :: [Int] -> [String]
> printedForm232 [] = []
> printedForm232 w | head w == 0 = "w0" : printedForm232 (tail w)
>                  | head w == 1 = "w1" : printedForm232 (tail w)
>                  | head w == 2 = "w2" : printedForm232 (tail w)

> w0 :: Int
> w0 = 0
> w1 :: Int
> w1 = 1
> w2 :: Int
> w2 = 2

> m232 ::  (WKripke, IKripke, JKripke)
> m232 = (w232 , i232, j232)

> w232 :: WKripke
> w232 = makeSet [w0,w1,w2]

> i232 :: IKripke
> i232 =  makeSet [('t', w2),('s',w1),('s',w2)]

> j232 :: JKripke
> j232 = makeSet [("Cy",(w1,w0)), ("Cy",(w1,w1)), ("Cy",(w2,w0)),
>              ("Di",(w0,w1)), ("Di",(w1,w0)), ("Di",(w2,w2))]

> a232 :: Form
> a232 = (Imply (Var 's') (Var 't'))

*Main> printedForm232 (flatten (em m232 a232))
["w0","w2"]

> b232 :: Form
> b232 = (Not (Imply (Var 's') (Var 't')))

*Main> printedForm232 (flatten (em m232 b232))
["w1"]

> c232 :: Form
> c232 = (Says (Name "Cy") (Imply (Var 's') (Var 't')))

*Main> printedForm232 (flatten (em m232 c232))
["w0","w2"]

> d232 :: Form
> d232 = (Says (Name "Cy") (Not (Imply (Var 's') (Var 't'))))

*Main> printedForm232 (flatten (em m232 d232))
["w0"]

> e232 :: Form
> e232 = (Says (Name "Di") (Imply (Var 's') (Var 't')))

*Main> printedForm232 (flatten (em m232 e232))
["w1","w2"]

> f232 :: Form
> f232 = (Says (Name "Di") (Not (Imply (Var 's') (Var 't'))))

*Main> printedForm232 (flatten (em m232 f232))
["w0"]

> g232 :: Form
> g232 = (Says (Together (Name "Cy") (Name "Di")) (Imply (Var 's') (Var 't')))

*Main> printedForm232 (flatten (em m232 g232))
["w2"]

> h232 :: Form
> h232 = (Says (Together (Name "Cy") (Name "Di")) (Not (Imply (Var 's') (Var 't'))))

*Main> printedForm232 (flatten (em m232 h232))
["w0"]

> iq232 :: Form
> iq232 = (Says (Quote (Name "Di") (Name "Cy")) (Imply (Var 's') (Var 't')))

*Main> printedForm232 (flatten (em m232 iq232))
["w1","w2"]

> jq232 :: Form
> jq232 = (Says (Quote (Name "Di") (Name "Cy")) (Not (Imply (Var 's') (Var 't'))))

*Main> printedForm232 (flatten (em m232 jq232))
["w1"]

> k232 :: Form
> k232 = (For (Name "Di") (Name "Cy"))

*Main> printedForm232 (flatten (em m232 k232))
[]

> l232 :: Form
> l232 = (Says (Name "Cy") (For (Name "Di") (Name "Cy")))

*Main> printedForm232 (flatten (em m232 l232))
["w0"]

> mq232 :: Form
> mq232 = (Says (Name "Di") (For (Name "Di") (Name "Cy")))

*Main> printedForm232 (flatten (em m232 mq232))
[]

> n232 :: Form
> n232 = (Says (Name "Di") (For (Together (Name "Di") (Name "Cy")) (Name "Cy")))

*Main> printedForm232 (flatten (em m232 n232))
["w0","w1","w2"]

-------------------------------------------------------------------------------

c  Total 34 point (10 point (represent the model) + 24 point (6  test,
   4 point each))

Exercise 2.3.3.


*** Put your answer below. For codes, DO NOT FORGET to add the > symbol ***

> printedForm233 :: [Int] -> [String]
> printedForm233 [] = []
> printedForm233 w | head w == 0 = "t" : printedForm233 (tail w)
>                  | head w == 1 = "u" : printedForm233 (tail w)
>                  | head w == 2 = "v" : printedForm233 (tail w)
>                  | head w == 3 = "x" : printedForm233 (tail w)
>                  | head w == 4 = "y" : printedForm233 (tail w)
>                  | head w == 5 = "z" : printedForm233 (tail w)

> t :: Int
> t = 0
> u :: Int
> u = 1
> v :: Int
> v = 2
> x :: Int
> x = 3
> y :: Int
> y = 4
> z :: Int
> z = 5

> m233 ::  (WKripke, IKripke, JKripke)
> m233 = (w233 , i233, j233)

> w233 :: WKripke
> w233 = makeSet [t,u,v,x,y,z]

> i233 :: IKripke
> i233 =  makeSet [('p', x),('p', y),('p',z), ('q', x), ('q', y), ('q', t), ('r', y), ('r', t), ('r', u), ('r', z)]

> j233 :: JKripke
> j233 = union b (union a origin)
>         where
>           origin = makeSet [("A",(x,y)), ("A",(x,z)), ("A",(z,t)),
>                             ("A",(y,v)), ("A",(v,y)), ("A",(v,x)),
>                             ("B", (y,t)), ("B", (z,t)), ("B",(t,v))]
>           b = makeSet [("B", (x,w)) | w <- (flatten w233)]
>           a = makeSet [("A", (w,w)) | w <- (flatten w233)]

> a233 :: Form
> a233 = Imply (Imply (Var 'p') (Var 'q')) (Var 'r')

*Main> printedForm233 (flatten (em m233 a233))
["t","u","y","z"]

> b233 :: Form
> b233 = Says (Name "A") (Imply (Var 'p') (Var 'r'))

*Main> printedForm233 (flatten (em m233 b233))
["t","u","y","z"]

> c233 :: Form
> c233 = Says (Name "A") (Says (Name "B") (Var 'q'))

*Main> printedForm233 (flatten (em m233 c233))
["u","y"]

> d233 :: Form
> d233 = Says (Name "B") (Says (Name "B") (Var 'q'))

*Main> printedForm233 (flatten (em m233 d233))
["t","u","v"]

> e233 :: Form
> e233 = Contr (Name "A") (Says (Name "B") (Var 'q'))

*Main> printedForm233 (flatten (em m233 e233))
["t","u","v","x","y","z"]

> f233 :: Form
> f233 = Contr (Name "A") (Contr (Name "B") (Var 'q'))

*Main> printedForm233 (flatten (em m233 f233))
["t","u","v","x","y","z"]

-------------------------------------------------------------------------------


d. Total 35 point (15 point (represent the model) + 20 point (10 point each))

Exercise 2.3.4.


*** Put your answer below. For codes, DO NOT FORGET to add the > symbol ***


Please name the objects and test cases you created used with suffix "234":

eg. m234 = (w234, i234, j234) and give answer to each part of the questions
with reasons (with verifiable computations, when applicable)

> printedForm234 :: [Int] -> [String]
> printedForm234 [] = []
> printedForm234 w | head w == 0 = "n"   : printedForm234 (tail w)
>                  | head w == 1 = "r"   : printedForm234 (tail w)
>                  | head w == 2 = "c"   : printedForm234 (tail w)
>                  | head w == 3 = "d"   : printedForm234 (tail w)
>                  | head w == 4 = "rc"  : printedForm234 (tail w)
>                  | head w == 5 = "rd"  : printedForm234 (tail w)
>                  | head w == 6 = "cd"  : printedForm234 (tail w)
>                  | head w == 7 = "rcd" : printedForm234 (tail w)

> n :: Int
> n = 0
> r :: Int
> r = 1
> c :: Int
> c = 2
> d :: Int
> d = 3
> rc :: Int
> rc = 4
> rd :: Int
> rd = 5
> cd :: Int
> cd = 6
> rcd :: Int
> rcd = 7

> m234 ::  (WKripke, IKripke, JKripke)
> m234 = (w234 , i234, j234)

> w234 :: WKripke
> w234 = makeSet [n,r,c,d,rc,rd,cd,rcd]

> i234 :: IKripke
> i234 =  makeSet [('r', r),('r', rc),('r',rd), ('r', rcd), ('c', c), ('c', rc), ('c', cd), ('c', rcd),
>                 ('d', d), ('d', rd), ('d', cd), ('d', rcd)]

> j234 :: JKripke
> j234 = union x (union y z)
>         where
>           z = makeSet [("Z",(w,n)) | w <- (flatten w234)]
>           x = makeSet [("X", (w, rcd)) | w <- (flatten w234)]
>           y = makeSet [("Y",(w,w)) | w <- (flatten w234)]

> a234 :: Form
> a234 = (Contr (Name "Y") (And (Var 'r') (Var 'c')))

This returns the entire world, so we can say that M |= Y controls (read ∧ copy).
*Main> printedForm234 (flatten (em m234 a234))
["n","r","c","d","rc","rd","cd","rcd"]

> b234 :: Form
> b234 = (Contr (Name "X") (Var 'd'))

This returns part of the world, so we can say M |/= X controls del. (Not equals)
*Main> printedForm234 (flatten (em m234 b234))
["d","rd","cd","rcd"]

-------------------------------------------------------------------------------

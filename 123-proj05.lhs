
-------------------------------------------------------------------------------

Spring 2022  CIS 623    Project 5

-------------------------------------------------------------------------------

-- > import Data.List

> import Test.QuickCheck
> import Set
> import Data.Char


-------------------------------------------------------------------------------

IMPORTANT NOTE:

It is expected taht your submission can be loaded to the GHCi interpreter
successfully. The grader will deduce points if your submission fails to do so.

-------------------------------------------------------------------------------

(10 point) Fill in the following information. You will lose 3 point for each
missing or incorrect answer.

Name: Andrew Boyce
SU email:amboyce@syr.edu
Number: 123

ie. The 3 digit number assigned to you

-------------------------------------------------------------------------------

Due date:

Release:	Mar 28, 2022
Due date:	Apr 02, 2022, 11:59 pm

Remarks:

1. (5 point)

You submission should be named as XXX-proj5.lhs where XXX is the 3 digit no.
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

Exercise 1

(a)  (30 point)

Consider the access control formula (ACL formula) defined in ACST.
The BNF is given in in ACST section 2.2.1 - 2.2.3  (p.18
for Princ, p.20 for Form)

First create a datatype Prin to represent principals based on the definition
given in page 18 and then create a datatype Form to represent ACL formulas
based on the given BNF in page 20.

> data Princ =  Name String | Together Princ Princ | Quote Princ Princ
>            deriving Show


data Form = ... fill in the details (See the def. of Prop in tautology.hs)

> data Form = PropVar Char     | Or Form Form     | And Form Form | Negation Form |
>             Subset Form Form | Equals Form Form | Implication Princ Princ |
>             Says Princ Form  | Controls Princ Form
>           deriving Show



-------------------------------------------------------------------------------

(b) (20 point)

For each well-formed ACL formula given in ACST Exercise 2.2.1
(i.e. a,c,e,f), create their representation using the definition
you gave in part (a) in the space below.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol ***

> f221a :: Form
> f221a = (Subset (And (PropVar 'p') (Negation (PropVar 'q'))) (Controls (Name "Cal") (PropVar 'r')))

> f221c :: Form
> f221c = (Says (Quote (Name "Mel") (Name "Ned")) (Subset (PropVar 'r') (PropVar 't')))

> f221e :: Form
> f221e = (Controls (Name "Ulf") (Implication (Quote (Name "Vic") (Name "Wex")) (Name "Tor")))

> f221f :: Form
> f221f = (Controls (Name "Pat") (Controls (Name "Quint") (Says (Name "Ryne") (PropVar 's'))))

-------------------------------------------------------------------------------

(c) (30 point)

Write a function isAForm

isAForm         :: Form -> Bool

which returns True if the input is a well formed ACL formula where

-- the propositional symbols used are either p, q, r, or s (each of type Char).
-- the Single principal used are Alice or Bob (each of type String).



 according to your definition in (a). Otherwise, the system  will report an
 error. You need use helper functions in your answer.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol ***


> isAForm :: Form -> Bool
> isAForm (PropVar x) | x == 'p' = True
>                     | x == 'q' = True
>                     | x == 'r' = True
>                     | x == 's' = True
>                     | otherwise = False
> isAForm (Or x y) | (isAForm x) && (isAForm y) = True
>                  | otherwise = False
> isAForm (And x y) | (isAForm x) && (isAForm y) = True
>                   | otherwise = False
> isAForm (Negation x) | (isAForm x) = True
>                      | otherwise   = False
> isAForm (Subset x y) | (isAForm x) && (isAForm y) = True
>                      | otherwise = False
> isAForm (Equals x y) | (isAForm x) && (isAForm y) = True
>                      | otherwise = False
> isAForm (Implication x y) | (isAPrinc x) && (isAPrinc y) = True
>                           | otherwise = False
> isAForm (Says x y) | (isAPrinc x) && (isAForm y) = True
>                    | otherwise = False
> isAForm (Controls x y) | (isAPrinc x) && (isAForm y) = True
>                        | otherwise = False
> isAForm _ = False

> isAPrinc :: Princ -> Bool
> isAPrinc (Name x) | x == "Alice" = True
>                   | x == "Bob" = True
> isAPrinc (Together x y) | (isAPrinc x) && (isAPrinc y) = True
>                         | otherwise = False
> isAPrinc (Quote x y) | (isAPrinc x) && (isAPrinc y) = True
>                      | otherwise = False
> isAPrinc _ = False


-------------------------------------------------------------------------------

(d) (20 point)

In Exercise 2.2.1, the formula in b and d are ill formed formula. Discuss
how it can be discovered in your implementation.

These ill formed formulas can be discovered in my implementation because
for example, if we look at "Says x y" in the function for isAForm, we check to
make sure that x is a Princ and that y is a Form. We check to make sure that x
is a Princ in this example by executing isAPinc on x to determine if it is
actually a Princ and we execute isAForm on y to determine if it is actually
a Form as well. In any of the cases where the input(s) are not of the proper
type for it to conform with the pattern, then we return false. This goes for
each case, and in the event that the pattern doesn't match, we return False
from the last case of isAPrinc and isAForm.





-------------------------------------------------------------------------------

Discussions: (No grade assigned. But will be useful in the next project)

Given an ACL formula, How to evaluate EM (Kripke semantics) ?

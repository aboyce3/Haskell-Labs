-------------------------------------------------------------------------------

Spring 2022  CIS 623    Project 3

-------------------------------------------------------------------------------

> import Data.List (nub)

-------------------------------------------------------------------------------

IMPORTANT NOTE:

It is expected taht your submission can be loaded to the GHCi interpreter
successfully. The grader will deduce points if your submission fails to do so.

-------------------------------------------------------------------------------

(10 point) Fill in the following information. You will lose 3 point for each
missing or incorrect answer.

Name: Andrew Boyce
SU email: amboyce@syr.edu
Number: 123

ie. The 3 digit number assigned to you

-------------------------------------------------------------------------------

Due date:

Release:	Feb 17, 2022
Due date:	Feb 24, 2022, 11:59 pm

Remarks:

1. (5 point)

You submission should be named as XXX-proj2.lhs where XXX is the 3 digit no.
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

Note:

1. Total =  75 point

2. To answer the programming questions, add the haskell code according to the
requirement. Your grader should be able to load your file in GHCi successfully.

*** DO NOT FORGET to add the > symbol below each line in your code. ***


--------------------------------------------------------------------------------

Exercise 1  (Total 30 point)

(a).  (15 point. Hutton, Section 5.7, Exercise 7)

Show how the list comprehension

[(x,y) | x <- [1,2], y <- [3,4]] with two generators can be re-expressed using
two comprehensions with single generators. Hint: nest one comprehension within
the other and make use of the library function concat :: [[a]] -> [a] .

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> ans :: [(Int,Int)]
> ans = concat [[(x, y) | x <- [1, 2]] | y <- [3, 4]]



--------------------------------------------------------------------------------

(b).  ((15 point. Hutton, Section 5.7, Exercise 8)

Redefine the function positions (call the new function positions1) using the function find , where, originally, the function find is defined as:


> find :: Eq a => a -> [(a,b)] -> [b]
> find k t = [v | (k',v) <- t, k == k']

and the function positions is defined as:

> positions :: Eq a => a -> [a] -> [Int]
> positions x xs = [i | (x',i) <- zip xs [0..], x == x']


*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> positions1 :: Eq a => a -> [a] -> [Int]
> positions1 x xs = find x (zip xs [0..n]) where n = ((length xs) - 1)


--------------------------------------------------------------------------------

Exercise 2 (Total 30 point)

--------------------------------------------------------------------------------

(a) (10 point)

Look up the function nub from hoogle.org.  In the space below, state its
type and it definitions in words.

*** Put your answer below.


The nub function consumes a list, removes any duplicates, and then returns the new list. It does this by keeping the first occurrence of each element in the list.


--------------------------------------------------------------------------------

(b) (20 point. Composition of relations)


The composition of two relations are defined in our text ACST, chapter 2
(also stated in HW 1).  Write a function compose, which will take
two binary relations xs ys (type [(a,a)]) as input, returns the composition
of the two relations. For example, suppose


> r1 :: [(Int,Int)]
> r1 = [(1,1),(1,2),(2,5),(5,1)]

> r3 :: [(Int,Int)]
> r3 = [(5,1),(2,2)]

> test0 = compose r1 r3

*Main> test0
[(1,2),(2,1)]


You may use the library function nub in your code.


*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> compose :: [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
> compose a b = nub [(x,z) | (x,y) <- a, (y',z) <- b, y == y']





--------------------------------------------------------------------------------

(c) (10 point, testing the compose function)

Create two examples to test your implementation of the compose function.
You may select them from the text. Please provide their Haskell definitions
as in r1 r3 above.




*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> r4 :: [(Int,Int)]
> r4 = [(1,1), (2,3), (2,1)]

> r5 :: [(Int,Int)]
> r5 =[(1,1), (1,4), (3,5)]

> test1 = compose r4 r5

> r6 :: [(Int,Int)]
> r6 = [(1,1), (1,4), (3,5)]

> r7 :: [(Int,Int)]
> r7 =  [(6,7), (7,8),(8,6)]

> test2 = compose r6 r7

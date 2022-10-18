-------------------------------------------------------------------------------

Spring 2022  CIS 623    Project 4

-------------------------------------------------------------------------------

> import Data.List

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

Release:	Feb 28, 2022
Due date:	Mar 07, 2022, 11:59 pm

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

1. Total =    point

2. To answer the programming questions, add the haskell code according to the
requirement. Your grader should be able to load your file in GHCi successfully.

*** DO NOT FORGET to add the > symbol below each line in your code. ***


--------------------------------------------------------------------------------

Exercise 1  (Total 60 point)

(a).  (20 point)

Consider the following function j:

> j      :: (Ord a) => [(a,a)] -> a -> [a]
> j xs x =   [ v  | (u,v) <- xs, u == x]

Rewrite the function by using the higher order function
map and filter. You may use lambda function in your answer.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> j1      :: (Ord a) => [(a,a)] -> a -> [a]
> j1 xs x = map snd (filter (\(x',_) -> x' == x) xs)


--------------------------------------------------------------------------------

(b).  (20 point)

Consider the function drop (a function in Prelude) of type"

drop :: Int -> [a] -> [a]

where drop n xs returns the suffix of xs after the first n
elements, or [] if n >= length xs.

Rewrite the function by using the higher order function
map and filter. You may use lambda function in your answer.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> drop1 :: Int -> [a] -> [a]
> drop1 n xs | n >= length xs = []
>            | otherwise = map fst (filter (\(_,y) -> y >= n) (zip xs [0..]))

--------------------------------------------------------------------------------

(c).  (20 point)

Consider the following function mapFuns which takes
a list of functions and apply them all to a particular argument.
We can define the function by recursion as follows:

> mapFuns      :: [a -> b] -> a -> [b]
> mapFuns [] x     =  []
> mapFuns (f:fs) x =  f x : mapFuns fs x

Rewrite the function by using the higher order function
map and filter. You may use lambda function in your answer.

mapFuns      :: [a -> b] -> a -> [b]

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> mapFuns1      :: [a -> b] -> a -> [b]
> mapFuns1 fs x = map (\f -> f x) fs


--------------------------------------------------------------------------------

Exercise 2 (Total 80 point)

--------------------------------------------------------------------------------

Sets are basic mathmatical objects we often use to build more sophisticated
mathematical objects. In this exercise, we will used a list to represent a set
and implement functions to perform basic set operations. Note that Sets
should be an instance of the class Eq.


(a)  Implement the union function (named as union1)

The union function returns the list union of the two lists. For
example,

main> "dog" `union` "cow"
"dogcw"

Duplicates, and elements of the first list, are removed from the
second list, but if the first list contains duplicates, so will
the result.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> union1 :: Eq a => [a] -> [a] -> [a]
> union1 xs ys = xs ++ filter (\y -> not (elem y xs)) (nub ys)


-------------------------------------------------------------------------------

(b)  Implement the intersect function (named as intersect1)

The intersect function takes the list intersection of two lists.
For example,

main> [1,2,3,4] `intersect` [2,4,6,8]
[2,4]
If the first list contains duplicates, so will the result.

main> [1,2,2,3,4] `intersect` [6,4,4,2]
[2,2,4]

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> intersect1 :: Eq a => [a] -> [a] -> [a]
> intersect1 xs ys = filter (\x -> (elem x ys)) xs


-------------------------------------------------------------------------------

(c)  Implement the subseteq function (named as subseteq1)

The function will take two lists xs ys as input, returns True
if xs is a subset of ys. Otherwise, it returns false.

NoteL Follow the set definition. That is, xs is a subset of ys
if for any x in xs, x is also an element in ys.  Do not use other
functions (such as elem) from the library.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> subseteq1 :: Eq a => [a] -> [a] -> Bool
> subseteq1 [] ys = True
> subseteq1 (x:xs) ys | subsetHelper x ys = subseteq1 xs ys
>                     | otherwise = False

> subsetHelper :: Eq a => a -> [a] -> Bool
> subsetHelper x [] = False
> subsetHelper x (y:ys) | x == y = True
>                       | otherwise = subsetHelper x ys

-------------------------------------------------------------------------------

(d) difference:

The difference function is list difference (non-associative). In the result of

difference xs ys

the first occurrence of each element of ys in turn (if any) has been removed
from xs. Thus

main> difference "Hello World!" "ell W"
"Hoorld!"

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> difference :: Eq a => [a] -> [a] -> [a]
> difference xs [] = xs
> difference [] ys = []
> difference xs (y:ys) | elem y xs = difference (differenceHelper xs y) ys
>                      | otherwise = difference xs ys

> differenceHelper :: Eq a => [a] -> a -> [a]
> differenceHelper [] _ = []
> differenceHelper (x:xs) y | y == x = xs
>                           | otherwise = x : differenceHelper xs y

-------------------------------------------------------------------------------

Question 1

> halve :: Int -> [a] -> ([a],[a])
> halve k xs = ((take k xs),(drop k xs))

Question 2 (Feijens Notation)
Given the function evaluate qs [3, 4, 1, 4, 2].
Show your steps using Feijen’s notation.

> qs :: Ord a => [a] -> [a]
> qs [] = [] -- qs.1
> qs (x:xs) = qs sml ++ [x] ++ qs lrg --qs.2
>   where
>     sml = [s | s <- xs, s <= x]
>     lrg = [l | l <- xs, x < l]

Feijens notation for "evaluate qs [3, 4, 1, 4, 2]":

qs [3,4,1,4,2]
={qs. 2}
qs sml ++ [x] ++ qs lrg
={simplify}
qs [1,2] ++ [3] ++ qs [4,4]
={qs. 2}
(qs sml ++ [1] ++ qs lrg) ++ [3] ++ (qs sml ++ [4] ++ qs lrg)
= {simplify, qs. 1}
(qs [] ++ [1] ++ qs [2]) ++ [3] ++ (qs [] ++ [4] ++ qs [4])
= {qs. 2, simplify}
([] ++ [1] ++ (qs [] ++ [2] ++ qs [])) ++ [3] ++ ([] ++ [4] ++ (qs [] ++ [4] ++ qs []))
={qs. 1}
([] ++ [1] ++ ([] ++ [2] ++ [])) ++ [3] ++ ([] ++ [4] ++ ([] ++ [4] ++ []))
={++ is associative}
[] ++ [1] ++ [] ++ [2] ++ [] ++ [3] ++ [] ++ [4] ++ [] ++ [4] ++ []
={simplify}
[1,2,3,4,4]

Question 3

> elm :: Eq a => a -> [a] -> Bool
> elm x [] = False
> elm x (x':xs) | x == x' = True
>               | otherwise = elm x xs

Question 4

> replicate1 :: Int -> a -> [a]
> replicate1 k x = [x | _ <- [1..k]]

Question 5

> q5 :: (Ord a) => [(a,a)] -> a -> [a]
> q5 xs x = [v | (u,v) <- xs, u==x]

> answer :: (Ord a) => [(a,a)] -> a -> [a]
> answer xs x = map snd (filter (\(x',y) -> x == x') xs)

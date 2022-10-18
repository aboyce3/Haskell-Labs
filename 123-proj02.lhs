-------------------------------------------------------------------------------

Spring 2022  CIS 623    Project 2

-------------------------------------------------------------------------------

> import Prelude hiding (init)

-------------------------------------------------------------------------------

(10 point) Fill in the following information. You will lose 3 point for each 
missing or incorrect answer.

Name: Andrew Boyce
SU email: amboyce@syr.edu
Number: 123

ie. The 3 digit number assigned to you

-------------------------------------------------------------------------------

Due date:

Release:	Feb 07, 2022  
Due date:	Feb 13, 2022, 11:59 pm

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

1. Total = 115 point

2. To answer the programming questions, add the haskell code according to the
requirement. Your grader should be able to load your file in GHCi successfully. 

*** DO NOT FORGET to add the > symbol below each line in your code. ***


-------------------------------------------------------------------------------- 

Exercise 1  (Total 50 point)

-------------------------------------------------------------------------------- 

(a) 20 point (wildcard pattern)

Complete the implementation of the functions nand (not and), xor (exclusive or) 
in the space provided. In your code, use the wildcard pattern _ to combine 
multiple equations. 

-------------------------------------------------------------------------------- 
i.  The nand function and xor function are both Boolean functions that defined
by truth tables. Look up their definitions and implement them as Haskell 
functions. Use the wildcard to simplify your code.


*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> nand           :: Bool -> Bool -> Bool
> nand True True = False
> nand _ _ = True




-------------------------------------------------------------------------------- 


ii.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.


> xor           :: Bool -> Bool -> Bool
> xor True False = True
> xor False True = True
> xor _ _ = False




-------------------------------------------------------------------------------- 


(b) 30 point (list patterns with simple recursion)  

i. Complete the imlementation of the function transfer in the space provided.
   The function takes a tuple of list, (xs,ys), as input, return the a tuple of 
   lists where 

   - the first component is the empty list []
   - the second component will the (reverse xs) ++ ys 
   
   be transferred from the first list to the head of the second list. For 
   example:

   *Main> transfer ([1,2],[3,4])
   ([],[2,1,3,4])

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> transfer :: ([a],[a]) -> ([a],[a])
> transfer ([], ys)     =  ([], ys)
> transfer ((x:xs), ys) =  transfer (xs, [x] ++ ys)


-------------------------------------------------------------------------------- 

ii. By using the transfer function, the library function snd (Hutton, p.41),
    complete the implementaton of the function reverse1, which works as 
    the library function reverse (Hutton, p.16). For example:

    *Main> reverse [1,2,3,4]
    [4,3,2,1]

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> reverse1    :: [a] -> [a]
> reverse1 xs = snd(transfer (xs,[]))



-------------------------------------------------------------------------------- 

iii.Recall that when specify the nth element of a list (n >= 0), we count
    from zero (Hutton, page 15-16). By following this convention, write the 
    function dropOdd which, take a list xs as input, removes all the elements
    from the list where their positions are odd numbers. For example:

    *Main> dropOdd [1,2,3,4]
    [1,3]
 
*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> dropOdd       :: [a] -> [a]  -- continue to fill in your code below
> dropOdd (x:xs)	| length xs > 0 = [x] ++ dropOdd (tail xs)
> dropOdd x = x






-------------------------------------------------------------------------------- 

Exercise 2 (Total 50 point)

-------------------------------------------------------------------------------- 

(a) (15 point. lambda expressions, modified from Hutton Section 4.8, ex. 7)

    Show, how the meaning of the following curried function definition 

> mult       :: Int -> Int -> Int -> Int
> mult x y z = x*y*z

can be formalized by defining the function in terms of lambda expressions. To
avoid naming conflicts, we will call the function you define mult1.

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

> mult1 :: Int -> Int -> Int -> Int
> mult1  = \x -> (\y -> (\z -> x * y * z))





Note: to complete this question, you may find the slides to Chapter 4 helpful.

-------------------------------------------------------------------------------- 

(b) (15 point. demonstrate the evaluation of functions defined by recursion, 
     modified from Hutton Section 6.8, exercise 5)            
    
    Use the recursive definitions given in chapter 6 (Hutton) and Feijen's      
    notation to show how each of the following expression is being evaluated. 


    i.       length [1,2,3]          

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

	length :: [a] -> Int
	length [] = 0                   --length.1
	length (_:xs) = 1 + length xs   --length.2

	Feijen's Notation:
	length [1,2,3] = {definition of :}
	length 1:[2,3] = {length.2}
	1 + length [2,3] = {length.2}
	1 + 1 + length 2:[3] = {length.2}
	1 + 1 + 1 +length 3:[] = {length.1}
	1 + 1 + 1 + 0 = {arithmetic}
	3

-------------------------------------------------------------------------------- 

    ii.      drop 3 [1,2,3,4,5]

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

	drop :: Int -> [a] -> [a]
	drop 0 xs 	= xs 		--drop.1
	drop _ []	= []		--drop.2
	drop n (_:xs) = drop (n-1) xs	--drop.3
	
	Feijen's Notation:
	drop 3 [1,2,3,4,5] = {definition of :}
	drop 3 1:[2,3,4,5] = {drop.3}
	drop 2 2:[3,4,5] = {drop.3}
	drop 1 3:[4,5] = {drop.3}
	drop 0 [4,5] = {drop.1}
	[4,5]

-------------------------------------------------------------------------------- 

    iii.     init [1,2,3]

*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.

	init :: [a] -> [a]
	init [_] = []			--init.1
	init (x:xs) x : init xs		--init.2
	
	Feijen's Notation
	init [1,2,3] = {definition of :}
	init 1:[2,3] 1 : init [2,3] = {init.2}
	init 2:[3] 2 : init [3] = {init.2}
	init [3] = {init.1}
	[1,2]


--------------------------------------------------------------------------------        

(c) (20 point. defining a function via recursion, Hutton Section 6.8, ex. 7)

    Define a recursive function  

    merge :: (Ord a) => [a] -> [a] -> [a]

    that merges two sorted lists of values to give a single sorted list. 

    For example:

    *main> merge [2,5,6] [1,3,4]
    [1,2,3,4,5,6]


*** Put your answer below. For codes, DO NOT FORGET to add the > symbol.
    
> merge :: (Ord a) => [a] -> [a] -> [a]
> merge [] ys = ys
> merge xs [] = xs
> merge (x:xs) (y:ys) | x <= y = [x] ++ merge xs (y:ys)
>                     | x > y  = [y] ++ merge (x:xs) ys
   
    



-------------------------------------------------------------------------------- 

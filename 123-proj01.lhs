-------------------------------------------------------------------------------

Spring 2022  CIS 623    Project 1

-------------------------------------------------------------------------------

> import Prelude hiding (init)

-------------------------------------------------------------------------------

Name: Andrew Boyce
Email: amboyce@syr.edu
Number: 123
ie. The 3 digit number assigned to you

-------------------------------------------------------------------------------

Due date:

Release:	Jan 31, 2022  
Due date:	Feb 06, 2022, 11:59 pm

Remarks:

1. You submission should be named as XXX-proj1.lhs where XXX is the 3 digit no.
   assigned to you in blackboard
2. We do not accept any late submissions.
3. If you encounter any difficulties, and but you can upload your submission 
   within an hour after the due date, please state the reason below:

State the reason(s) for late submission below (if needed):


4. If you cannot upload your submission within an hour after the due date
   because of a valid reason (eg. network/power outage etc.)  contact the 
   grader at tjiang15@syr.edu when email is available. Your grader will not 
   grade your work but you may receive an exemption.

-------------------------------------------------------------------------------- 

Note: 

To answer the programming questions, add the haskell code according to the
requirement. DO NOT FORGET to add the > symbol below each line in your code.

-------------------------------------------------------------------------------- 

Exercise 1

-------------------------------------------------------------------------------- 

Write the library function init by using the library functions, length, take 
and any numeric functions such as  + , - , * etc.. Your implementation should 
agree with the implementation in Prelude for any non-empty lists.

(a)
 
> init    :: [a] -> [a]
> init xs = take (length xs - 1) xs

(b)

A test case for init is:

> test1 = init [1,2]

expected result: [1]

Write another test case (test2) together with an expected result, for the 
function init below:

test2 = [1,2,3]

expected result: [1,2]

-------------------------------------------------------------------------------- 

Exercise 2 (specify data: a list)

(a)

In Hutton, section 3.3, four examples of lists are given and each has a 
different type. The types are: [Bool], [Char], [String], [[Char]]. For each
of these examples, give an alternate example in the space below. The examples
you give should be non-empty lists.

> eg2a1 :: [Bool]
> eg2a1 = [True, True]        -- your example

> eg2 :: [Char]
> eg2 = ['c', 'h', 'a', 'r']        -- your example

> eg2a3 :: [String]
> eg2a3 = ["Hello", "World"]      -- your example

> eg2a4 :: [[Char]]
> eg2a4 = [['H','e','l','l','o'], ['W','o','r','l','d']]      -- your example

(b)

In Hutton, section 3.4, tuple types are introduced and examples are given.
For each of the following tuple types section from section 3.4, given an
alternate example.

> eg2b1 :: (Char, (Bool, Char))
> eg2b1 =  ('a', (True, 'b'))        -- your example  

> eg2b2 :: [(Char, Bool)] 
> eg2b2 =  [('a', False), ('b', True)]       -- your example  

(c)

Consider the following Haskell code:

> val1 = 1
> val2 = True
> val3 = "Alice"

Explain why it is not legitimate to create the list [val, val2, val3].

Answer:

Since the members of a list must be of the same type. As val1 and 
val2 are of different types, this will produce a type error.


-------------------------------------------------------------------------------- 








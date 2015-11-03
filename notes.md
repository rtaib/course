Haskell general notes
=====================

Functional programming is where you can change the call to a function by its value and not change the program.

He took the example of a function which prints a value then returns the product of 2 arguments. When replacing the function by its returned value, and reusing that value multiple times, the printing occurs only once.

One consequence is you cannot write a for loop

:load  to load and compile code
:r  to reload the code
:info
:: means 'has the type'

All Haskell functions take a single argument, but they can nest several levels, e.g.

:info (++)   -- shortcut :i
(++) :: [a] -> [a] -> [a] 	-- Defined in ‘GHC.Base’
infixr 5 ++

This means (++) takes 1 argument [a] and returns a function that takes 1 argument [a] and returns a [a].

(++) could be redefined as
(++.) :: [b] -> ([b] -> [b]) -- Here the parenthesese are redundant
(++.) x =
	((++) x)

Functions should be defined in 2 parts: the type definition, followed by the actual code

Parentheses vs. backticks, depend on whether the name starts with an alpha char
append x y
x `append` y

(++) x y
x ++ y


To list the contents of a module use :browse
For example, the basic Haskell module:
:browse Prelude


Lists can contain any type, but all elements must contain the same type
There is no None/null element

https://www.haskell.org/hoogle/ can be used to look up functions by arguments

Getting started with the course code
------------------------------------
	cd ~/git/course
	chmod 755 .
	ghci
This should open and compile a bunch of code


Other notes
-----------
Once inhabited type
:i const
const :: a -> b -> a

If else constructs:
bye = if True then 7 else 8


Haskell reads the code from the top and stops as soons as it finds a match

Type classes are similar to interfaces. They can be used to "constrain" some input to a function
class Ord a where
  compare :: a -> a -> Ordering
  data Ordering = EQ | LT | GT

They can be instantiated for specific types e.g.
instance Ord Banana where
  compare :: Banana -> Banana -> Ordering
This code can be avoided by deriving the Ord class

Use them to constrain input e.g.
(Eq a, Ord a) => [a] -> [a]

The number of instances satisfying a class decreases as the class becomes more specific, but on the other hand there are more derived operations becoming available. For example, Ord is a subset of Eq (in terms of instances), but checking for equality is a subset of sorting.

Functor has signature * -> *  (i.e. type returns type)

Pointfree (and pointful) can be used to factor in expressionss. Install using cabal: `sudo cabal install pointfree` then add `~/.cabal/bin` to the path, e.g. in `~/.bashrc`.

Background on the reasoning can be found in SKI Combinator Calculus

Hackage is a repository for Haskell libraries


Haskell can be written similarly to declarative code, e.g. from Haxl:
numCommonFriends x y =
    length <$> (intersect <$> friendsOf x <*> friendsOf y)

Becomes:

numCommonFriends x y = do
  fx <- friendsOf x
  fy <- friendsOf y
  return (length (intersect fx fy))
  

module MyFirst where

x = "abc"

-- Line comment
{- Block comment -}
func ::
    [Char]
    -> [Char]
y = 2
func list =
    list ++ "def"
append = (++) -- Define an 'add' function
{- then use it as prefix
append "abc" "def"
or infix
"abc" `append` "def"
-}


name1 :: ([Char] -> a) -> a
name1 f =
    f "abc"
-- name1 reverse  will return "cba"

-- Defining an inline (lambda) function by using the \ sign:
-- name1 (\q -> "t" ++ q)
-- or -- name1 (\q -> 't' : q)  -- Note the single vs. double quotes

{- Data type definition: 
data DataTypeName (0 or more typeparams) =
Constructor1 (0 or more arguments)
| Constructor2 ...
-}
-- Example, building a Json data format definition
data Json =
    JBool Bool
    | JString String
    | JNull
    | JNumber Int
    | JArray [Json]
    | JObject [(String, Json)]
-- Each element on the left e.g. JString is whatever name you choose, followed by the type is carries

data Shape =
  Circle Int
  | Rectangle Int Int

-- Similar to __str__ or toString()
instance Show Shape where
  show (Circle r) =
    "Circle of radius " ++ show r
  show (Rectangle w h) =
    "Rectangle of width " ++ show w ++ " and height " ++ show h
-- Show is defined as a sort of interface:
-- class Show a where
--   show :: a -> String

-- All the boiler plate code cabn be avoided by using the keyword 'deriving'. This works for specific functions e.g. Show and where the arguments are known for that function e.g. Int
-- Useful to derive equality for example
data Shape2 =
  Circle2 Int
  | Rectangle2 Int Int
  deriving (Eq, Show)
-- Now we can test: Rectangle2 4 5 == Circle2 6

pii = 3 -- Integer Pi
perimeter :: Shape2 -> Int
perimeter (Circle2 r) =
  2 * r *pii
perimeter (Rectangle2 w h) =
  2* (w + h)
area :: Shape2 -> Int
area (Circle2 r) =
  let t = r * r
  in t * pii
area (Rectangle2 w h) =
  w * h

-- When developing, can use 'undefined' which is a placeholder that simply throws an exception, but at list this will compile
rev :: [a] -> [a]
rev list =
--   foldl undefined undefined list
-- then evolve it to
--   foldl undefined _undef list
-- The compiler will explain what type is expected for _undef
-- then go to
--   fold _undef [] list
-- Again use the compiler to explain what goes in _undef, then
--  foldl (\q a -> a : q) [] list
-- equivalent to
--  foldl (\q  a -> (:) a q) [] list
-- and flipping arguments
--  foldl (\q  a -> flip (:) q a) [] list
-- Which can be simplified into
--  foldl (\q  -> flip (:) q) [] list
-- and even more
  foldl (flip (:)) [] list

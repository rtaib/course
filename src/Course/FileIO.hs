{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RebindableSyntax #-}

module Course.FileIO where

import Course.Core
import Course.Applicative
import Course.Apply
import Course.Bind
import Course.Functor
import Course.List

{-

Useful Functions --

  getArgs :: IO (List Chars)
  putStrLn :: Chars -> IO ()
  readFile :: Chars -> IO Chars
  lines :: Chars -> List Chars
  void :: IO a -> IO ()

Abstractions --
  Applicative, Monad:

    <$>, <*>, >>=, =<<, pure

Problem --
  Given a single argument of a file name, read that file,
  each line of that file contains the name of another file,
  read the referenced file and print out its name and contents.

Example --
Given file files.txt, containing:
  a.txt
  b.txt
  c.txt

And a.txt, containing:
  the contents of a

And b.txt, containing:
  the contents of b

And c.txt, containing:
  the contents of c

$ runhaskell FileIO.hs "files.txt"
============ a.txt
the contents of a

============ b.txt
the contents of b

============ c.txt
the contents of c

-}

-- /Tip:/ use @getArgs@ and @run@
main ::
  IO ()
main =
  getArgs >>= \a -> case a of
    Nil -> putStrLn "Argument missing"
    h:._ -> run h

-- error (show h)

type FilePath =
  Chars

-- /Tip:/ Use @getFiles@ and @printFiles@.
run ::
  Chars
  -> IO ()
run fp =
  readFile fp >>= \contents -> 
  getFiles (lines contents) >>= \c -> -- c is a list of filenames and contents
  printFiles c
-- OR rewrite as: --
-- do
--   f <- readFile a
--   c <- getFiles(lines f)
--   printFiles c

getFiles ::
  List FilePath
  -> IO (List (FilePath, Chars))
getFiles fs =
  sequence (getFile <$> fs)

getFile ::
  FilePath
  -> IO (FilePath, Chars)
getFile =
--getFile f =
--  readFile f >>= \c -> pure(f, c)
-- OR:
-- (\c -> (f,c)) <$> readFile f -- Use a pair instead of pure 
-- (\c -> (,) f c) <$> readFile f
-- ((,) f) <$> readFile f
  lift2 (<$>) (,) readFile

printFiles ::
  List (FilePath, Chars)
  -> IO ()
printFiles x =
  void (sequence ((\(p, c) -> printFile p c) <$> x))
-- OR:
--  void (sequence ((uncurry printFile) <$> x))

printFile ::
  FilePath
  -> Chars
  -> IO ()
printFile p c =
  putStrLn ("===== " ++ p) *> -- Use an anonymous binding at the end 
--  putStrLn ("Contents: " ++ c)
  getChar >>= \thechar ->  -- How to get user inputs
  putStrLn ("Contents: " ++ c ++ show' thechar) -- There is an error here, not sure why


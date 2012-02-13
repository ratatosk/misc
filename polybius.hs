module Main where

import Data.Maybe
import Data.List
import Data.Char
import qualified Data.Bimap as B

prepare = map (\c -> if c == 'j' then 'i' else c) . filter (`elem` ['a'..'z']) . map (toLower)

table key = let nk = nub key in nk ++ filter (`notElem` ('j':nk)) ['a'..'z']

mkMap key = B.fromList $ zip (table key) (map (\i -> [i `rem` 5, i `quot` 5]) [0..])

toCoords m c = fromJust $ B.lookup c m
fromCoords m c = fromJust $ B.lookupR c m

toPairs = unfoldr (\x -> if null x then Nothing else Just (take 2 x, drop 2 x))
fromPairs xs = let l = length xs `quot` 2 in [take l xs, drop l xs]

morph k f = map (fromCoords m) . f . map (toCoords m) where m = mkMap k

encode k = morph k $ toPairs . concat . transpose
decode k = morph k $ transpose . fromPairs . concat

main = do
  putStrLn "Enter key:"
  k <- getLine
  putStrLn "Enter plaintext:"
  t <- getLine
  let pk = prepare k
  let pt = prepare t
  putStrLn $ "Prepared key: " ++ pk
  putStrLn $ "Prepared plaintext: " ++ pt
  let ct = encode pk pt
  putStrLn $ "Ciphertext: " ++ ct
  let dt = decode pk ct
  putStrLn $ "Decoded plaintext: " ++ dt
  if dt == pt 
    then putStrLn "Test passed."
    else putStrLn "Text failed."
  main

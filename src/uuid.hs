-- License: BSD3 (see LICENSE)
-- Author: Dino Morelli <dino@ui3.info>

{-# LANGUAGE OverloadedStrings #-}

import Data.Char ( ord )
import Data.UUID ( UUID (..), fromString, nil, toString )
import Data.UUID.V4 ( nextRandom )
import Data.UUID.V5 ( generateNamed )
import Data.Word ( Word8 )
import Text.Printf


main :: IO ()
main = do
   let inputNs = "FooBarBaz"
   let ns = mkUUID nil inputNs
   putStrLn "namespace UUID:"
   printf "%s: \"%s\"\n" (toString ns) inputNs

   putStrLn "\nUsing that namespace for UUIDs (v5):"
   let inputDino = "Dino"
   printf "%s: \"%s\"\n" (toString $ mkUUID ns inputDino) inputDino

   let inputBetty = "Betty"
   printf "%s: \"%s\"\n" (toString $ mkUUID ns inputBetty) inputBetty

   putStrLn "\nRandomly generated (v4):"
   putStrLn =<< toString `fmap` nextRandom


mkUUID :: UUID -> String -> UUID
mkUUID ns str =
   let input = map (fromIntegral . ord) str :: [Word8]
   in generateNamed ns input

-- License: BSD3 (see LICENSE)
-- Author: Dino Morelli <dino@ui3.info>

import Codec.Binary.UTF8.String ( encode )
import Data.UUID ( UUID (..), nil, toString )
import Data.UUID.V4 ( nextRandom )
import Data.UUID.V5 ( generateNamed )
import Text.Printf ( printf )


main :: IO ()
main = do
   let inputNs = "made-up namespace string"
   let ns = mkUUID nil inputNs
   putStrLn "\nMaking a custom namespace UUID:"
   printf "%s: \"%s\"\n" (toString ns) inputNs

   putStrLn "\nUsing that namespace to generate UUIDs (v5):"
   let input1 = "dogs and cats"
   printf "%s: \"%s\"\n" (toString $ mkUUID ns input1) input1

   let input2 = "kangaroos and wallabees"
   printf "%s: \"%s\"\n" (toString $ mkUUID ns input2) input2

   putStrLn "\nRandomly generated (v4):"
   putStrLn =<< toString `fmap` nextRandom


{- There are several ways to do this, but a good idea is UTF8
encoding (package utf8-string) which is less lossy than Char8
to Word8.
-}
mkUUID :: UUID -> String -> UUID
mkUUID ns = generateNamed ns . encode

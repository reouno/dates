module Main where

import qualified Data.ByteString.Lazy     as BS
import           Network.Wai.Handler.Warp

import           App.Server               ( app )

main :: IO ()
main = do
  top <- BS.readFile "./dist/index.html"
  run 8081 $ app top

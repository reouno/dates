module Main where

import           Network.Wai.Handler.Warp

import           App.Server               ( app )

main :: IO ()
main = run 8081 app

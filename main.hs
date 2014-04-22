module Main where

import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.IO as TIO

import System.Environment

import Propylgraph.Sentences

parseArgs :: [String] -> IO ()
parseArgs (inputFileName : []) = TIO.readFile inputFileName >>= print . ((concatMap adjacencies) . sentences)
parseArgs _                    = putStrLn "You're a dummy."

main = getArgs >>= parseArgs

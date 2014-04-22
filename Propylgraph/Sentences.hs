{-# LANGUAGE OverloadedStrings #-}

module Propylgraph.Sentences (sentences, pairs) where

import Data.List
import qualified Data.Text.Lazy as T

sentenceTerminators :: [Char]
sentenceTerminators = ".?!"

punctuation :: [Char]
punctuation = "~`$%^&*()_-+=|\\}]{[\"':;/><,"

sentences :: T.Text -> [[T.Text]]
sentences xs = filter (not . null) $ map T.words phrases
    where phrases = filter (not . T.null) chunks
          chunks = T.split (`elem` sentenceTerminators) $
                   T.filter (`notElem` punctuation) $
                   T.toLower xs

diag :: [a] -> [(a, a)]
diag []        = []
diag (_:[])    = []
diag (x:x':xs) = (x, x') : diag (x' : xs)

heads :: [a] -> [(a, [a])]
heads []    = []
heads (x:[]) = [(x, [])]
heads (x:xs) = (x, xs) : heads xs

echelon :: [a] -> [(a, a)]
echelon = (concatMap f) . heads
    where f (x, xs) = map (\n -> (x, n)) xs

pairs :: [a] -> ([(a, a)], [(a, a)])
pairs xs = (diag xs, echelon xs)

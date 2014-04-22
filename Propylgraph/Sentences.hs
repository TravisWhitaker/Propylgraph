{-# LANGUAGE OverloadedStrings #-}

module Propylgraph.Sentences (sentences) where

import Data.List
import qualified Data.Text.Lazy as T

sentenceTerminators :: [Char]
sentenceTerminators = ".?!"

punctuation :: [Char]
punctuation = "~`$%^&*()_-+=|\\}]{[\"':;/><,"

sentences :: T.Text -> [[T.Text]]
sentences xs = filter (not . null) $ map T.words phrases
    where phrases = filter (not . T.null) chunks
          chunks = T.split (`elem` sentenceTerminators) $ T.filter (`notElem` punctuation) $ T.toLower xs

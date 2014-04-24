{-# LANGUAGE OverloadedStrings #-}

module Propylgraph.RDF where

import Control.Monad

import Data.List
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.IO as TIO

rdfHeader :: T.Text
rdfHeader = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<rdf:RDF\n  xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n  xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\"\n  xmlns:pg=\"pg/\">\n\n"

rdfTerminator :: T.Text
rdfTerminator = "\n</rdf:RDF>"

-- Just a wrapper, subject to fusion.
rdfContextIO :: FilePath -> T.Text -> IO ()
rdfContextIO path f = TIO.writeFile path (T.append (T.append rdfHeader f) rdfTerminator)

-- Also subject to fusion.
diagToRDF :: (T.Text, T.Text) -> T.Text
diagToRDF (s, o) = "<rdf:Description rdf:about=\"" `T.append`
                   s `T.append`
                   "\">\n  <pg:adj rdf:resource=\"" `T.append`
                   o `T.append`
                   "\">\n</rdf:Description>\n"

-- Also also subject to fustion.
echelonToRDF :: (T.Text, T.Text) -> T.Text
echelonToRDF (s, o) = "<rdf:Description rdf:about=\"" `T.append`
                      s `T.append` 
                      "\">\n  <pg:sen rdf:resource=\"" `T.append`
                      o `T.append`
                      "\">\n</rdf:Description>\n"

{-# LANGUAGE ViewPatterns #-}
module PageRouter where

import Network.URI
import PageRender
import JSUtils
import Debug.Trace

routePage :: URI -> Page -> Page
routePage uri _ = traceShow (uriFragment uri) $ case uriFragment uri of 
  "" -> HomePage
  "#" -> HomePage
  "#human" -> HumanHomePage
  "#cryptoparty" -> CryptoPartyPage Nothing
  ((=~ "#cryptoparty/(.+)") -> [_,x]) -> CryptoPartyPage $ Just x

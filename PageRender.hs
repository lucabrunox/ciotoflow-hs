{-# LANGUAGE OverloadedStrings #-}

module PageRender where

import Prelude hiding (div)
import Text.Blaze.Html5 hiding (map)
import Text.Blaze.Html5.Attributes
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
    
data Page = HomePage | OtherPage
 deriving (Show)

renderPage :: Page -> Html
renderPage HomePage = do
  H.head $ do
    H.title "foo"
  H.body $ do
    div ! class_ "dsa" $ do
      p "A list of natural numbers:"
      a "asd" ! href "#"
renderPage OtherPage = do
  H.head $ do
    H.title "another page"
  H.body $ do
    div $ do
      p "Pagina cambiata!!!"
      a "torna alla home" ! href "#"

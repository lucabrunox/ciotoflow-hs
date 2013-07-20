module DOMUtils where

import GHCJS.DOM
import GHCJS.DOM.DOMWindow
import GHCJS.DOM.Document
import GHCJS.DOM.Element
import GHCJS.DOM.HTMLElement
import GHCJS.DOM.Text
import GHCJS.DOM.Node
import GHCJS.DOM.NodeList
import GHCJS.DOM.Types

import Utils
import Control.Applicative
import Data.Maybe

emptyHtmlElement :: IsHTMLElement a => a -> IO ()
emptyHtmlElement elem = htmlElementSetInnerHTML elem ""

nodeGetChildList :: IsNode a => a -> IO [Node]
nodeGetChildList node = do
  mlist <- nodeGetChildNodes node
  maybeDo mlist (return []) $ \list -> do
    len <- nodeListGetLength list
    catMaybes <$> mapM (nodeListItem list) [0..len-1]

replaceChildren :: (IsHTMLElement a, IsNode b) => a -> b -> IO ()
replaceChildren htmlElem rep = do
  emptyHtmlElement htmlElem
  let node = castToNode htmlElem
  children <- nodeGetChildList rep
  mapM_ (nodeAppendChild node . Just) children

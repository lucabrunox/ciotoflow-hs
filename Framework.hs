{-# LANGUAGE ExistentialQuantification, RankNTypes #-}

module Framework where

import Text.Blaze.Html5 hiding (map)
import Text.Blaze.Html5.Attributes
import GHCJS.DOM
import GHCJS.DOM.DOMWindow
import GHCJS.DOM.Document
import GHCJS.DOM.Element
import GHCJS.DOM.HTMLElement
import GHCJS.DOM.Text
import GHCJS.DOM.Node
import GHCJS.DOM.NodeList
import GHCJS.DOM.Types
import Control.Applicative
import Text.Blaze.Html.Renderer.GHCJS
import Utils
import Control.Monad.ListM

import DOMUtils

type Handler a = IO a -> IO ()

handler :: Application a -> Handler a
handler app h = do
  page <- h
  let html = renderApplication app page
  setPageHtml html
  setupApplication app (handler app) page

data Application a = Application { homePage :: a,
                                   renderApplication :: a -> Html,
                                   setupApplication :: Handler a -> a -> IO () }

runApplication :: Application a -> IO ()
runApplication app = do
  let home = homePage app
  let html = renderApplication app home
  setPageHtml html
  setupApplication app (handler app) home

setPageHtml :: Html -> IO ()
setPageHtml html = do
  Just document <- currentDocument
  Just head <- documentGetHead document
  nodes <- renderHtml document html

  -- Find head and body of the generated nodes
  let elements = map castToHTMLElement nodes
  newHead <- findM (\x -> (== "HEAD") <$> elementGetTagName x) elements
  newBody <- findM (\x -> (== "BODY") <$> elementGetTagName x) elements
  -- Replace new head and body
  maybeDo_ newHead $ \x -> do
    replaceChildren head x
  maybeDo_ newBody $ \x -> do
    documentSetBody document $ Just x

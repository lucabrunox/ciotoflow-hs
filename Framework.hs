{-# LANGUAGE ExistentialQuantification, RankNTypes #-}

module Framework where

import Text.Blaze.Html5 (Html)
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

type Step a = IO a -> IO ()

step :: Application a -> Step a
step app h = do
  page <- h
  let html = renderPage app page
  setPageHtml html
  setupPage app (step app) page

data Application a = Application { homePage :: a,
                                   renderPage :: a -> Html,
                                   setupPage :: Step a -> a -> IO () }

runApplication :: Application a -> IO ()
runApplication app = do
  let home = homePage app
  let html = renderPage app home
  setPageHtml html
  setupPage app (step app) home

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

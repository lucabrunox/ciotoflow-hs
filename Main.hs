{-# LANGUAGE RankNTypes #-}

module Main where

import Prelude hiding (div)
import GHCJS.DOM
import GHCJS.DOM.DOMWindow
import GHCJS.DOM.Document
import GHCJS.DOM.Element
import GHCJS.DOM.HTMLElement
import GHCJS.DOM.Text
import GHCJS.DOM.Node
import GHCJS.DOM.NodeList
import GHCJS.DOM.Types
import GHCJS.Foreign
import Control.Applicative
import Control.Monad
import Data.Maybe
import Text.Blaze.Html5 (Html)
import Text.Blaze.Html.Renderer.GHCJS 
import Data.List
import Control.Monad.ListM

import PageRender
import Utils
import DOMUtils
import Framework hiding (renderPage, setupPage, routePage)
import PageRender
import PageActions
import PageRouter

main = do
  Just win <- currentWindow
  let app = Application HomePage renderPage setupPage routePage
  runApplication app

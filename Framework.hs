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
import GHCJS.Marshal
import GHCJS.Types
import Control.Applicative
import Text.Blaze.Html.Renderer.GHCJS
import Utils
import JSUtils
import Control.Monad.ListM
import Control.Concurrent.MVar
import Network.URI
import GHCJS.History
import qualified JavaScript.JQuery as J
import Data.Default
import DOMUtils
import Data.Text (pack)

type Step a = (a -> IO a) -> IO ()

data Application a = Application { homePage :: a,
                                   renderPage :: a -> Html,
                                   setupPage :: Step a -> a -> IO (),
                                   routePage :: URI -> a -> a
                                 }

data IntState a = IntState { application :: Application a,
                             pageVar :: MVar a }

stepper :: IntState a -> Step a
stepper state h = do
  cur <- readMVar (pageVar state)
  page <- h cur
  let app = application state
  let html = renderPage app page
  setPageHtml html
  setupPage app (stepper state) page

loadDocumentURI :: IntState a -> a -> IO a
loadDocumentURI s page = do
  Just document <- currentDocument
  url <- documentURL document
  let uri = parseURI url
  maybeDo uri (return page) $ \uri -> do
    let app = application s
    let newpage = routePage app uri page
    return newpage

historyChanged :: IntState a -> Event -> IO ()
historyChanged s _ = (stepper s) (loadDocumentURI s)

runApplication :: Application a -> IO ()
runApplication app = do
  Just win <- currentWindow
  let home = homePage app
  pageVar <- newMVar home
  let state = IntState app pageVar
  jwin <- J.selectObject (castRef $ unDOMWindow win)
  historyAdapterBind win "anchorchange" (historyChanged state)
  let step = stepper state
  step $ loadDocumentURI state

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

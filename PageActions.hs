{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module PageActions where

import Prelude hiding (find)
import GHCJS.DOM
import GHCJS.DOM.DOMWindow
import GHCJS.DOM.Types hiding (Event)
import JavaScript.JQuery
import Data.Default
import Data.Text.Internal (Text)

import Framework
import Utils
import PageRender

default (Data.Text.Internal.Text)

type PHandler = Handler Page

changePage :: PHandler -> JQuery -> Event -> IO ()
changePage h a e = h $ do
  return OtherPage

gotoHomePage :: PHandler -> JQuery -> Event -> IO ()
gotoHomePage h a e = h $ do
  return HomePage

setupPage :: PHandler -> Page -> IO ()
setupPage h HomePage = do
  print "asd"
  a <- select "a"
  click (changePage h a) def a
  return ()
setupPage h OtherPage = do
  a <- select "a"
  click (gotoHomePage h a) def a
  return ()
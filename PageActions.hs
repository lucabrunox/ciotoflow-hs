{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module PageActions where

import Prelude hiding (find)
import GHCJS.DOM
import GHCJS.DOM.DOMWindow
import JavaScript.JQuery
import Data.Default
import Data.Text (Text, pack)

import Framework hiding (Step)
import qualified Framework as F
import Utils
import PageRender
import JSUtils
import DOMUtils
import Data.List
import Control.Applicative

default (Data.Text.Text)

type Step = F.Step Page

toHumanHomePage :: Step -> JQuery -> Event -> IO ()
toHumanHomePage s a e = s $ do
  return HumanHomePage

setupPage :: Step -> Page -> IO ()
setupPage s HomePage = do
  a <- select "a.human"
  click (toHumanHomePage s a) def a
  
  return ()

setupPage s HumanHomePage = do
  random <- select ".random"
  r <- mathRandom
  let idx = floor (r * genericLength randomPhrases)
      phrase = randomPhrases !! idx
  setHtml phrase random
  return ()

randomPhrases :: [Text]
randomPhrases = map (\x -> pack $ "Il ciotoflow è " ++ x) [
    "la copia non autorizzata della bibbia",
    "un gestore di pompe funebri nei tempi morti",
    "una ciotia",
    "un null pointer",
    "quella cosa con protuberanze in rj45",
    "quella cosa con un cat7 in posizione eretta",
    "un pò quel cazzo che ti pare",
    "alla fine che come all'inizio andava qualcuno che però programmava in Vala",
    "un pò come ipv6 che si esite,ma però che palle alla fine aspetto la fine del mondo",
    "un case arrugginito vicino a un cassonetto pieno di wikiqoute",
    "un bot sclerato sull'orlo di fallire il test di Turing,ma che però potrebbe lavorare alla durex",
    "un testo random stampato sulla carta d'identità di Gioacchino Croce incrociato al semaforo"
    ]

{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module PageRender where

import Prelude hiding (div, head, span, id)
import Text.Blaze.Html4.Transitional hiding (map, style)
import Text.Blaze.Html4.Transitional.Attributes hiding (title, span, wrap)
import qualified Text.Blaze.Html4.Transitional as H
import qualified Text.Blaze.Html4.Transitional.Attributes as A
import BlazeUtils hiding (link)
import qualified BlazeUtils as A
import Data.Text.Internal (Text)

default (Data.Text.Internal.Text)
    
data Page = HomePage | HumanHomePage | NerdHomePage
 deriving (Show)

renderPage :: Page -> Html
renderPage HomePage = do
  head $ do
    meta ! httpEquiv "Content-Type" ! content "text/html; charset=UTF-8"
    title "Ciotoflow - Lascia fluire la ciotia"
    link ! rel "stylesheet" ! type_ "text/css" ! href "css/style.css"
    link ! rel "icon" ! href "cioto_human/images/favicon.png" ! type_ "image/png"
    
  body ! alink "#aaffaa" ! A.link "white" ! vlink "#62cc5c" $ do
    div ! align "center" $ do
      h1 "CiotoFlow"
      p "*** Let the _CIOTIA_ flows out! ***"
      a ! href "#" ! class_ "human" $ do
        img ! src "images/human_side.png"
      a ! href "#" ! class_ "nerd" $ do
        img ! src "images/robot_side.png"
      br
      br
      a ! href "#" ! class_ "human" $ "Versione umana"
      wrap $ "    "
      a ! href "#" ! class_ "nerd" $ "Versione nerd"

renderPage HumanHomePage = do
  head $ do
    meta ! httpEquiv "Content-Type" ! content "text/html; charset=UTF-8"
    title "CiotoSite - for !(nerd)"
    link ! rel "stylesheet" ! type_ "text/css" ! href "css/style.css"
    link ! rel "icon" ! href "cioto_human/images/favicon.png" ! type_ "image/png"
  body $ do
    div ! align "center" $ do
      h1 $ do
        a ! href "human.html" ! style "color: #cccccc; text-decoration: none;" $ "CiotoFlow"
      h3 $ "*** Let the _CIOTIA_ flows out! ***"
    br
    br
    table ! style "text-align: left; width: 100%;" ! border "0" ! cellpadding "2" ! cellspacing "2" $ do
      tbody $ do
        tr $ do
	  td ! style "vertical-align: top;" ! width "30%" $ do
            div ! align "center" $ do
              h1 $ "Incontro Settimanale"
	      p $ do
                "tutti i Mercoled&igrave; all'aula P2occupata "
		"Cubo 40c UniCal, Rende (CS) alle circa meno "
		"quasi 18:00"
              br
              br
	      h1 "Contatti"
	      p ! id "contatti" $ do
		"mailing-list: "
                a ! href "https://www.autistici.org/mailman/listinfo/ciotoflow" $ "ciotoflow [at] autistici [dot] org"
	  td ! style "vertical-align: top;" ! width "40%" $ do
	    div ! align "center" $ do
	      img ! src "images/walkingascii.gif"
	      h2 ! class_ "random" $ ""
	  td ! style "vertical-align: top;" ! width "30%" $ do
	    div ! align "center" ! id "news" $ do
	      h1 $ do
                a ! href "cryptoparty.html" $ "!Cryptoparty!"
              p "- Perche' in  paranoia stat virtus -"
              p "Fu il 27-mar-13 @p2Occupata"
	      h1 $ do
                a ! href "warmup.html" $ "Warmup hackit 0x0E"
              p "seminari e rassegna cinematografica <br/> in attesa dell'apocalisse del 2012"
    br
    br
    br
    div $ do
      a ! rel "license" ! target "_new" ! href "http://creativecommons.org/licenses/by-nc/3.0/" $ do
	img ! alt "Creative Commons License" ! style "border-width:0" ! src "http://i.creativecommons.org/l/by-nc/3.0/80x15.png"
      " "
      a ! rel "Hacker Emblem" ! target "_new" ! href "http://www.catb.org/hacker-emblem/" $ do
	img ! style "border-width:0" ! src "images/hacker.png"

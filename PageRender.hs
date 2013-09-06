{-# LANGUAGE OverloadedStrings, ExtendedDefaultRules #-}

module PageRender where

import Prelude hiding (div, head, span, id)
import Text.Blaze.Html4.Transitional hiding (map, style)
import Text.Blaze.Html4.Transitional.Attributes hiding (title, span)
import qualified Text.Blaze.Html4.Transitional as H
import qualified Text.Blaze.Html4.Transitional.Attributes as A
import BlazeUtils hiding (link)
import qualified BlazeUtils as A
import Data.Text hiding (head)

default (Data.Text.Text)
    
data Page = HomePage | HumanHomePage | NerdHomePage | CryptoPartyPage | NotFoundPage
 deriving (Show)

pageUrl :: Page -> String
pageUrl HomePage = "#"
pageUrl HumanHomePage = "#human"
pageUrl NerdHomePage = "#nerd"
pageUrl CryptoPartyPage = "#cryptoparty"

url :: Page -> AttributeValue
url = toValue . pageUrl

commonHead :: Html
commonHead = do
  meta ! httpEquiv "Content-Type" ! content "text/html; charset=UTF-8"
  link ! rel "stylesheet" ! type_ "text/css" ! href "css/style.css"
  link ! rel "icon" ! href "cioto_human/images/favicon.png" ! type_ "image/png"


renderPage :: Page -> Html
renderPage HomePage = do
  head $ do
    commonHead
    title "Ciotoflow - Lascia fluire la ciotia"
    
  body ! alink "#aaffaa" ! A.link "white" ! vlink "#62cc5c" $ do
    div ! align "center" $ do
      h1 "CiotoFlow"
      p "*** Let the _CIOTIA_ flows out! ***"
      a ! href (url HumanHomePage) ! class_ "human" $ do
        img ! src "images/human_side.png"
      a ! href (url NerdHomePage) ! class_ "nerd" $ do
        img ! src "images/robot_side.png"
      br
      br
      a ! href "#" ! class_ "human" $ "Versione umana"
      wrap $ "    "
      a ! href "#" ! class_ "nerd" $ "Versione nerd"

renderPage HumanHomePage = do
  head $ do
    commonHead
    title "CiotoSite - for !(nerd)"
  
  body $ do
    div ! align "center" $ do
      h1 $ do
        a ! href (url HumanHomePage) ! style "color: #cccccc; text-decoration: none;" $ "CiotoFlow"
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
                "tutti i Mercoledì all'aula P2occupata "
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
                a ! href (url CryptoPartyPage) $ "!Cryptoparty!"
              p "- Perchè in  paranoia stat virtus -"
              p "Fu il 27-mar-13 @p2Occupata"
	      h1 $ do
                a ! href "warmup.html" $ "Warmup hackit 0x0E"
              p "seminari e rassegna cinematografica" 
              p "in attesa dell'apocalisse del 2012"
    br
    br
    br
    div $ do
      a ! rel "license" ! target "_new" ! href "http://creativecommons.org/licenses/by-nc/3.0/" $ do
	img ! alt "Creative Commons License" ! style "border-width:0" ! src "http://i.creativecommons.org/l/by-nc/3.0/80x15.png"
      " "
      a ! rel "Hacker Emblem" ! target "_new" ! href "http://www.catb.org/hacker-emblem/" $ do
	img ! style "border-width:0" ! src "images/hacker.png"

renderPage CryptoPartyPage = do
  head $ do
    commonHead
    link ! rel "stylesheet" ! type_ "text/css" ! href "css/cryptoblack.css"
    title "!!!CryptoParty!!!"
    
  body $ do
    div ! class_ "header" $ do
      a ! href (url HumanHomePage) ! style "text-decoration: none;" $ "CiotoFlow"
      div "*** Let the _CIOTIA_ flows out! ***"
    div ! class_ "titolo" $ ""
    div ! class_ "wrapper" $ do
      div ! class_ "sottomenu" $ "27 marzo 2013 Aula P2 Occupata - cubo 40c/unical"
      div ! class_ "sottomenu" $ do
        a ! id "mcose" ! href "#cose" ! class_ "clicked" $ "Cos'è"
        a ! id "mprogramma" ! href "#programma" $ "Programma"
        a ! id "mseminario" ! href "#seminario" $ "Seminario"
        a ! id "mmusica" ! href "#musica" $ "Musica"
        a ! id "minstallfest" ! href "#installfest" $ "Installfest/Banchetti"
        a ! id "mlocandina" ! href "#locandina" $ "Locandina"
        a ! id "mcontribuisci" ! href "#contribuisci" $ "Contribuisci"
        a ! id "mmateriali" ! href "#materiali" $ "Materiali"
      div ! class_ "paragrafi" ! id "cose" $ do
        div "Vuoi che le tue email e chat private siano leggibili solo da te?"
        div "Pensi che i tuoi dati personali debbano essere protetti da manomissioni e occhi indiscreti?"
        div "Ti piacerebbe pubblicare e navigare in maniera totalmente anonima?..."
        div "Allora impara a sfruttare a pieno gli strumenti per comunicare in modo sicuro, sfuggire a intercettazioni, censura e cifrare le tue \"coseprivate\"..."
        div $ do
          "Ma fallo durante una festa sperimentando e mettendoci le mani dentro! Il "
          em "cryptoparty"
          "non e' altro che una festa dove fra birra e musica imparerai a proteggere la tua privacy e i tuoi dati!"
      div ! id "programma" ! class_ "paragrafi" $ do
        div ! class_ "orario" $ "h18.00"
        div "Seminario sull'autodifesa digitale"
        div ! class_ "orario" $ "A seguire" 
        div "Cena social"
        div $ a ! href "#" $ "InstallFest"
      div $ a ! href "#" $ "Autoproduzioni && controinformazione"
      div ! class_ "orario" $ "h22.00"
      div "Mad Monkey Sound Selection (musiche dal mondo - dall'Africa ai balcani)"
      div "Djset NSA (Noize Spike Assault)"
      div ! id "seminario" ! class_ "paragrafi" $ do 
        h "seminario"
      div $ do 
        "Il seminario cercherà di dare le competenze"
        "necessarie per utilizzare in modo semplice e indolore tutti gli"
        "strumenti che ci permettano di cifrare/decifrare le mail e i dati sul nostro pc (" >> em "gpg/truecrypt" >> ")"
        "navigare anonimamente nella rete (" >> em "tor" >> ")e poter chattare senza paura di"
        "essere intercettati/letti (" >> em "otr" >> ")."
      div ! id "musica" ! class_ "paragrafi" $ do
        h "Musica" 
        div ! class_ "orario" $ "h22.00"
        div $ a ! href "https://www.facebook.com/italo.esposito.18" $ "Mad Monkey Sound Selection (musiche dal mondo - dall'Africa ai balcani)"
      div "Djset NSA (Noize Spike Assault)"
    
      div ! id "installfest" ! class_ "paragrafi" $ do 
        h "installfest/banchetti"
        div $ do 
          "A termine del seminario e durante la cena"
          "sociale, " >> em "INSTALLFEST" >> ": se porti il tuo pc"
          "estirpiamo winzozz e mettiamo linux.. ;) ! Tanti " >> em "BANCHETTI CRITTOGRAFICI" >> "dove potrai approfondire " 
          "e sperimentare quello che hai scoperto durante il seminario, ma anche trovare " >> em "AUTOPRODUZIONI"
          "e materiale di " >> em "CONTROINFORMAZIONE"
      div ! id "locandina" ! class_ "paragrafi" $ do 
        h "Locandina"
        div $ do 
          "Questa è la locandina preparata per l'evento, sentiti libero di " >> em "spammarla"
          "con qualunque mezzo di cui tu disponga:"
          div ! style "text-align: center; margin: 10px" $
            a ! href "/data/crypt_A3.pdf" $ img ! alt "locandina" ! src "images/locandina_crypt_thumb.png"
      div ! id "materiali" ! class_ "paragrafi" $ do 
        h "Materiali"
        div $ do
          "Tada ecco le slide, poche parole tanti screenshot "
          a ! href "data/slides.pdf" $ "qui"
          "Qua invece il "
          a ! href "https://cryptoparty.org/wiki/CryptoPartyHandbook" $ "libro guida del cryptoparty"
          "(in inglese)"
          "Spazia praticamente su tutti gli argomenti del seminario e non solo! Spread cryptography!"
    div $ do
      "Allora non fare il timido e raggiungici alla riunione"
      "settimanale del ciotoflow, ogni mercoledì alle piu o meno circa 18:00 sempre in Aula"
      "P2/occupata, oppure manda una mail in lista: "
      a ! href "https://www.autistici.org/mailman/listinfo/ciotoflow" $ "ciotoflow [at] autistici [dot] org"

renderPage NotFoundPage = do
  head $ do
    meta ! httpEquiv "Content-Type" ! content "text/html; charset=UTF-8"
    title "CiotoSite - E!FOUND"
    link ! rel "stylesheet" ! type_ "text/css" ! href "css/style.css"
    link ! rel "icon" ! href "cioto_human/images/favicon.png" ! type_ "image/png"
  body $ do
    div ! align "center" $ do
      h1 $ do
        a ! href (url HomePage) ! style "color: #cccccc; text-decoration: none;" $ "CiotoFlow"
      h3 $ "*** Page not found! ***"

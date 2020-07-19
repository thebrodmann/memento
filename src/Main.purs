module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Web.HTML (HTMLElement)
import Monarch (Command, Upstream)
import Monarch as Monarch
import Monarch.VirtualDOM
import Monarch.Event (Event, eNever)
import Memento.DOM as DOM


type Model = Unit

type Message = Void

type Output = Void

init :: Model 
init = unit

update :: Message -> Model -> Model
update _ = identity

view :: Model -> VirtualNode Message
view model =
  h_ "div" [ text "Hello World" ]

command :: Message -> Model -> Command () Message Output Unit
command _ _ = pure unit

interpreter :: Command () Message Output Unit -> Command () Message Output Unit
interpreter = identity

subscription :: Upstream Model Message -> Event Message
subscription = const eNever

main :: Effect Unit
main = do
  container <- DOM.getRootHTMLElement
  Monarch.document_ { init
                    , update
                    , view
                    , command
                    , interpreter
                    , subscription
                    , container
                    }

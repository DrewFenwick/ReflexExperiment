{-# language NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings, OverloadedLabels #-}

module Gui
  ( mkElements
  , mkGuiActions
  , setupGui
  , GuiTriggers(..)
  , GuiElements(..)
  , GuiActions(..)) where

import qualified GI.Gtk as Gtk
import Data.GI.Base
import Control.Concurrent.MVar
import Data.Text

data GuiTriggers = GuiTriggers
  { buttonTrigger :: IO ()
  }

data GuiElements = GuiElements
  { getWindow :: Gtk.Window
  , getButton :: Gtk.Button
  }

data GuiActions = GuiActions {
  retitleButton :: Text -> IO ()
}

mkGuiActions :: GuiElements -> GuiActions
mkGuiActions GuiElements{getButton = button} = GuiActions 
  { retitleButton = Gtk.buttonSetLabel button
  }

mkElements :: IO GuiElements
mkElements = do
  Gtk.init Nothing
  win <- new Gtk.Window [ #title := "My First App" ]
  button <- new Gtk.Button [ #label := "Click me" ]
  pure $ GuiElements win button

setupGui :: GuiElements -> GuiTriggers -> IO ()
setupGui guiElements guiTriggers = do
  let
    window = getWindow guiElements
    button = getButton guiElements
    btTrig = buttonTrigger guiTriggers
  on window #destroy Gtk.mainQuit
  on button #clicked btTrig
  #add window button
  #showAll window


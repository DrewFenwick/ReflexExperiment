{-# language NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings, OverloadedLabels #-}

module Gui (gui, GuiTriggers(..)) where

import qualified GI.Gtk as Gtk
import Data.GI.Base

data GuiTriggers = GuiTriggers
  { buttonTrigger :: IO ()
  }

gui :: GuiTriggers -> IO ()
gui GuiTriggers{ buttonTrigger } = do
  Gtk.init Nothing

  win <- new Gtk.Window [ #title := "My First App" ]

  on win #destroy Gtk.mainQuit

  button <- new Gtk.Button [ #label := "Click me" ]

  on button #clicked buttonTrigger

  #add win button

  #showAll win

  Gtk.main


{-# LANGUAGE OverloadedStrings, OverloadedLabels #-}

module App (app) where

import qualified GI.Gtk as Gtk
import Data.GI.Base

app :: IO ()
app = do
  Gtk.init Nothing

  win <- new Gtk.Window [ #title := "My First App" ]

  on win #destroy Gtk.mainQuit

  button <- new Gtk.Button [ #label := "Click me" ]

  on button #clicked (set button [ #sensitive := False,
                                   #label := "Thanks for clicking me" ])

  #add win button

  #showAll win

  Gtk.main
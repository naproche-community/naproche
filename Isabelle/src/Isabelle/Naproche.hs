{- generated by Isabelle -}

{-
Authors: Makarius (2018)

String constants for Isabelle/Naproche.
-}

module Isabelle.Naproche
where

-- options

naproche_prove, naproche_check, naproche_skipfail :: String
naproche_prove = "naproche_prove"
naproche_check = "naproche_check"
naproche_skipfail = "naproche_skipfail"


-- environment

naproche_pide, naproche_pos_file, naproche_pos_shift :: String
naproche_pide = "NAPROCHE_PIDE"
naproche_pos_file = "NAPROCHE_POS_FILE"
naproche_pos_shift = "NAPROCHE_POS_SHIFT"


-- message origin

origin, origin_main, origin_export, origin_forthel, origin_parser,
  origin_reasoner, origin_simplifier, origin_thesis :: String
origin = "origin"
origin_main = "Main"
origin_export = "Export"
origin_forthel = "ForTheL"
origin_parser = "Parser"
origin_reasoner = "Reasoner"
origin_simplifier = "Simplifier"
origin_thesis = "Thesis"
origin_translate = "Translation"


-- server commands

command_args :: String
command_args = "command_args"

cancel_command :: String
cancel_command = "cancel"

forthel_command :: String
forthel_command = "forthel"

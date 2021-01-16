{- generated by Isabelle -}

{-  Title:      Isabelle/Term_XML/Encode.hs
    Author:     Makarius
    LICENSE:    BSD 3-clause (Isabelle)

XML data representation of lambda terms.

See also "$ISABELLE_HOME/src/Pure/term_xml.ML".
-}

{-# LANGUAGE LambdaCase #-}

module Isabelle.Term_XML.Encode (indexname, sort, typ, typ_body, term)
where

import Isabelle.Library
import qualified Isabelle.XML as XML
import Isabelle.XML.Encode
import Isabelle.Term

indexname :: P Indexname
indexname (a, b) = if b == 0 then [a] else [a, int_atom b]

sort :: T Sort
sort = list string

typ :: T Typ
typ ty =
  ty |> variant
   [\case { Type (a, b) -> Just ([a], list typ b); _ -> Nothing },
    \case { TFree (a, b) -> Just ([a], sort b); _ -> Nothing },
    \case { TVar (a, b) -> Just (indexname a, sort b); _ -> Nothing }]

typ_body :: T Typ
typ_body ty = if is_dummyT ty then [] else typ ty

term :: T Term
term t =
  t |> variant
   [\case { Const (a, b) -> Just ([a], list typ b); _ -> Nothing },
    \case { Free (a, b) -> Just ([a], typ_body b); _ -> Nothing },
    \case { Var (a, b) -> Just (indexname a, typ_body b); _ -> Nothing },
    \case { Bound a -> Just ([], int a); _ -> Nothing },
    \case { Abs (a, b, c) -> Just ([a], pair typ term (b, c)); _ -> Nothing },
    \case { App a -> Just ([], pair term term a); _ -> Nothing }]

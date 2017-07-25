module Util exposing (..)

import Html


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


{-| infixl 0 means the (=>) operator has the same precedence as (<|) and (|>),
meaning you can use it at the end of a pipeline and have the precedence work out.
-}
infixl 0 =>


showIf : Html.Html m -> Bool -> Html.Html m
showIf html condition =
    if condition then
        html
    else
        Html.text ""


indexOf : a -> List a -> Maybe Int
indexOf item list =
    case list of
        [] ->
            Nothing

        x :: xs ->
            if x == item then
                Just 0
            else
                Maybe.map ((+) 1) (indexOf item xs)


lastItem : List a -> Maybe a
lastItem list =
    case list of
        [] ->
            Nothing

        [ x ] ->
            Just x

        _ :: xs ->
            lastItem xs

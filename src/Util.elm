module Util exposing ((=>), showIf)

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

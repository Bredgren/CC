module Main exposing (main)

import Data.Entry as Entry exposing (Entry, entryToHtml)
import Html exposing (..)
import Json.Decode exposing (decodeString)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { entries : List Entry
    }


init : ( Model, Cmd Msg )
init =
    ( Model [ Result.withDefault (Entry "" "" []) (decodeString Entry.decoder """{"date": "2017-1-1", "notes":"", "exercises":[]}""") ], Cmd.none )



-- UPDATE


type Msg
    = NewMessage String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewMessage str ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Entries" ]
        , div [] (List.map entryToHtml model.entries)
        ]

module Main exposing (main)

import Data.Entry as Entry exposing (Entry, entryToHtml)
import Html
import Html.Attributes as Attrs
import Html.Events as Events
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
    ( Model [ Result.withDefault (Entry "" "" []) (decodeString Entry.decoder """{"date": "2017-1-1", "notes":"This is notes. Hi.", "exercises":[]}""") ], Cmd.none )



-- UPDATE


type Msg
    = NewMessage String
    | Upload


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewMessage str ->
            ( model, Cmd.none )

        Upload ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.input
            [ Attrs.type_ "file"

            -- , Events.onchange FilesSelect
            ]
            []
        , Html.button [ Events.onClick Upload ] [ Html.text "Upload" ]
        , Html.h2 [] [ Html.text "Entries" ]
        , Html.div [] (List.map entryToHtml model.entries)
        ]

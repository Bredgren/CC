module Main exposing (main)

import Data.Entry as Entry exposing (Entry, entryToHtml)
import FileReader as FR
import Html
import Html.Attributes as Attrs
import Html.Events as Events
import Json.Decode as JD
import Task
import Util exposing (showIf)


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
    , selectedFile : Maybe FR.NativeFile
    , uploadedFileContents : String
    , errors : List String
    , editEntry : Maybe Entry
    }


init : ( Model, Cmd Msg )
init =
    ( { entries = []
      , selectedFile = Nothing
      , uploadedFileContents = ""
      , errors = []
      , editEntry = Nothing
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Upload
    | FilesSelect (List FR.NativeFile)
    | FileData (Result FR.Error String)
    | NewEntry


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Upload ->
            case model.selectedFile of
                Just selected ->
                    { model | errors = [] } ! [ readTextFile selected ]

                Nothing ->
                    { model | errors = [] } ! []

        FilesSelect fileInstances ->
            { model
                | selectedFile = List.head fileInstances
            }
                ! []

        FileData (Ok str) ->
            let
                data =
                    JD.decodeString (JD.list Entry.decoder) str
            in
            case data of
                Ok d ->
                    { model | uploadedFileContents = str, entries = d } ! []

                Err err ->
                    { model | errors = (err ++ " :: " ++ str) :: model.errors } ! []

        FileData (Err err) ->
            { model | errors = FR.prettyPrint err :: model.errors } ! []

        NewEntry ->
            model ! []


readTextFile : FR.NativeFile -> Cmd Msg
readTextFile fileValue =
    FR.readAsTextFile fileValue.blob
        |> Task.attempt FileData



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
            , onchange FilesSelect
            ]
            []
        , Html.button [ Events.onClick Upload ] [ Html.text "Upload" ]
        , showIf (Html.div [] [ Html.text <| "Errors: " ++ String.join ", " model.errors ]) (List.length model.errors > 0)
        , Html.h2 [] [ Html.text "Entries" ]
        , Html.div [] (List.map entryToHtml model.entries)
        ]


onchange : (List FR.NativeFile -> value) -> Html.Attribute value
onchange action =
    Events.on "change" (JD.map action FR.parseSelectedFiles)

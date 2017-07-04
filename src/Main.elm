module Main exposing (main)

import Data.Entry as Entry exposing (Entry, entryToHtml)
import Date
import DatePicker exposing (defaultSettings)
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
    , datePicker : DatePicker.DatePicker
    , date : Maybe Date.Date
    }


init : ( Model, Cmd Msg )
init =
    let
        ( datePicker, datePickerCmd ) =
            DatePicker.init
    in
    ( { entries = []
      , selectedFile = Nothing
      , uploadedFileContents = ""
      , errors = []
      , editEntry = Nothing
      , datePicker = datePicker
      , date = Nothing
      }
    , Cmd.map SetDatePicker datePickerCmd
    )



-- UPDATE


type Msg
    = Upload
    | FilesSelect (List FR.NativeFile)
    | FileData (Result FR.Error String)
    | NewEntry
    | SetDatePicker DatePicker.Msg


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
            { model | editEntry = Just (Entry "" "" []) } ! []

        SetDatePicker msg ->
            let
                ( newDatePicker, datePickerCmd, dateEvent ) =
                    DatePicker.update datePickerSettings msg model.datePicker

                date =
                    case dateEvent of
                        DatePicker.NoChange ->
                            model.date

                        DatePicker.Changed newDate ->
                            newDate

                newEntry =
                    Maybe.map (\e -> { e | date = dateToString date }) model.editEntry
            in
            { model
                | date = date
                , datePicker = newDatePicker
                , editEntry = newEntry
            }
                ! [ Cmd.map SetDatePicker datePickerCmd ]


datePickerSettings : DatePicker.Settings
datePickerSettings =
    { defaultSettings
        | inputClassList = [ ( "form-control", True ) ]
        , inputId = Just "datepicker"
    }


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
        , viewEditEntry model model.editEntry
        , showIf (Html.div [] [ Html.text <| "Errors: " ++ String.join ", " model.errors ]) (List.length model.errors > 0)
        , Html.h2 [] [ Html.text "Entries" ]
        , Html.div [] (List.map entryToHtml model.entries)
        ]


viewEditEntry : Model -> Maybe Entry -> Html.Html Msg
viewEditEntry model maybeEntry =
    case maybeEntry of
        Nothing ->
            Html.div []
                [ Html.button [ Events.onClick NewEntry ] [ Html.text "New Entry" ] ]

        Just entry ->
            Html.div []
                [ DatePicker.view
                    model.date
                    datePickerSettings
                    model.datePicker
                    |> Html.map SetDatePicker

                -- [ Html.input [ Attrs.type_ "date", Events.on "select" (JD.map UpdateEditDate JD.string) ] []
                , Html.text <| "Date: " ++ entry.date ++ ", " ++ dateToString model.date
                ]


onchange : (List FR.NativeFile -> value) -> Html.Attribute value
onchange action =
    Events.on "change" (JD.map action FR.parseSelectedFiles)


dateToString : Maybe Date.Date -> String
dateToString d =
    let
        monthToInt month =
            case month of
                Date.Jan ->
                    "1"

                Date.Feb ->
                    "2"

                Date.Mar ->
                    "3"

                Date.Apr ->
                    "4"

                Date.May ->
                    "5"

                Date.Jun ->
                    "6"

                Date.Jul ->
                    "7"

                Date.Aug ->
                    "8"

                Date.Sep ->
                    "9"

                Date.Oct ->
                    "10"

                Date.Nov ->
                    "11"

                Date.Dec ->
                    "12"
    in
    case d of
        Just date ->
            toString (Date.year date) ++ "-" ++ monthToInt (Date.month date) ++ "-" ++ toString (Date.day date)

        Nothing ->
            "no date"

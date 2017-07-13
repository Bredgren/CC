module Main exposing (main)

import Data.Entry as Entry
import Data.Exercise as Exercise
import Date
import DatePicker exposing (defaultSettings)
import Dict
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
    { entries : List Entry.Entry
    , selectedFile : Maybe FR.NativeFile
    , uploadedFileContents : String
    , errors : List String
    , editEntry : Maybe Entry.Entry
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
    | SaveEntry
    | SetDatePicker DatePicker.Msg
    | SelectExercise String
    | RemoveExercise String
    | AddSet String
    | RemoveSet String Int
    | SetReps String Int Int
    | ToggleWarmup String Int


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
            { model | editEntry = Just (Entry.Entry "" "" []) } ! []

        SaveEntry ->
            let
                newModel =
                    case model.editEntry of
                        Just entry ->
                            { model | entries = entry :: model.entries, editEntry = Nothing }

                        Nothing ->
                            model
            in
            newModel ! []

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

        SelectExercise exerciseName ->
            let
                newEntry =
                    Maybe.map (\e -> { e | exercises = e.exercises ++ [ Entry.Exercise exerciseName [] ] }) model.editEntry
            in
            { model | editEntry = newEntry } ! []

        RemoveExercise exerciseName ->
            let
                newEntry =
                    Maybe.map (\e -> { e | exercises = List.filter (\e -> e.name /= exerciseName) e.exercises }) model.editEntry
            in
            { model | editEntry = newEntry } ! []

        AddSet exercise ->
            let
                updateExercise e =
                    if e.name == exercise then
                        { e | sets = e.sets ++ [ Entry.Set 0 False ] }
                    else
                        e

                newEntry e =
                    { e | exercises = List.map updateExercise e.exercises }
            in
            { model | editEntry = Maybe.map newEntry model.editEntry } ! []

        RemoveSet exercise setIndex ->
            let
                updateExercise e =
                    if e.name == exercise then
                        { e | sets = List.take setIndex e.sets ++ List.drop (setIndex + 1) e.sets }
                    else
                        e

                newEntry e =
                    { e | exercises = List.map updateExercise e.exercises }
            in
            { model | editEntry = Maybe.map newEntry model.editEntry } ! []

        SetReps exercise setIndex reps ->
            let
                updateSet i s =
                    if i == setIndex then
                        { s | reps = reps }
                    else
                        s

                updateExercise e =
                    if e.name == exercise then
                        { e | sets = List.indexedMap updateSet e.sets }
                    else
                        e

                newEntry e =
                    { e | exercises = List.map updateExercise e.exercises }
            in
            { model | editEntry = Maybe.map newEntry model.editEntry } ! []

        ToggleWarmup exercise setIndex ->
            let
                updateSet i s =
                    if i == setIndex then
                        { s | warmup = not s.warmup }
                    else
                        s

                updateExercise e =
                    if e.name == exercise then
                        { e | sets = List.indexedMap updateSet e.sets }
                    else
                        e

                newEntry e =
                    { e | exercises = List.map updateExercise e.exercises }
            in
            { model | editEntry = Maybe.map newEntry model.editEntry } ! []


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
        , Maybe.withDefault (Html.text "-") (Maybe.map Entry.entryToHtml model.editEntry)
        , Html.h2 [] [ Html.text "Entries" ]
        , Html.div [] (List.map Entry.entryToHtml model.entries)
        ]


viewEditEntry : Model -> Maybe Entry.Entry -> Html.Html Msg
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
                , Html.div [] (List.map viewEditEntryExercise entry.exercises)
                , Html.div []
                    [ exerciseSelect (List.map (\e -> e.name) (Maybe.withDefault (Entry.Entry "" "" []) model.editEntry).exercises)
                    ]
                , Html.button [ Events.onClick SaveEntry ] [ Html.text "Save" ]
                ]


viewEditEntryExercise : Entry.Exercise -> Html.Html Msg
viewEditEntryExercise exercise =
    Html.div []
        [ Html.h3 []
            [ Html.text exercise.name
            , Html.button [ Events.onClick (RemoveExercise exercise.name) ] [ Html.text "-" ]
            ]
        , Html.ol [] (List.indexedMap (viewEditEntrySet exercise.name) exercise.sets)
        , Html.button [ Events.onClick (AddSet exercise.name) ] [ Html.text "+" ]
        ]


viewEditEntrySet : String -> Int -> Entry.Set -> Html.Html Msg
viewEditEntrySet exerciseName setIndex set =
    Html.li []
        [ Html.input
            [ Attrs.type_ "number"
            , Attrs.min "0"
            , Attrs.value (toString set.reps)
            , onRepCountChange exerciseName setIndex
            ]
            []
        , Html.label []
            [ Html.input
                [ Attrs.type_ "checkbox"
                , Events.onClick (ToggleWarmup exerciseName setIndex)
                ]
                []
            , Html.text "warmup"
            ]
        , Html.button [ Events.onClick (RemoveSet exerciseName setIndex) ]
            [ Html.text "-" ]
        ]


onRepCountChange : String -> Int -> Html.Attribute Msg
onRepCountChange exerciseName setNum =
    let
        targetToSetReps str =
            SetReps exerciseName setNum (Result.withDefault 0 (String.toInt str))
    in
    Events.on "change" (JD.map targetToSetReps Events.targetValue)


onchange : (List FR.NativeFile -> value) -> Html.Attribute value
onchange action =
    Events.on "change" (JD.map action FR.parseSelectedFiles)


exerciseSelect : List String -> Html.Html Msg
exerciseSelect alreadySelected =
    let
        toOpt exerciseName =
            Html.option [ Attrs.disabled (List.member exerciseName alreadySelected) ]
                [ Html.text exerciseName ]

        toOptGroup ( groupName, exerciseList ) =
            Html.optgroup [ Attrs.attribute "label" groupName ]
                (List.map toOpt exerciseList)
    in
    Html.select
        [ Events.on "change" (JD.map SelectExercise Events.targetValue)
        ]
        ([ Html.option
            [ Attrs.selected True, Attrs.disabled True ]
            [ Html.text "---" ]
         ]
            ++ List.map toOptGroup (Dict.toList Exercise.groups)
        )


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

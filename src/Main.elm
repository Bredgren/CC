port module Main exposing (main)

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
import Json.Encode as JE
import Task
import Util exposing (showIf)


main : Program String Model Msg
main =
    Html.programWithFlags
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


init : String -> ( Model, Cmd Msg )
init initLogStr =
    let
        ( datePicker, datePickerCmd ) =
            DatePicker.init
    in
    ( { entries = JD.decodeString (JD.list Entry.decoder) initLogStr |> Result.withDefault []
      , selectedFile = Nothing
      , uploadedFileContents = ""
      , errors = []
      , editEntry = Nothing
      , datePicker = datePicker
      , date = Nothing
      }
    , Cmd.batch
        [ Cmd.map SetDatePicker datePickerCmd
        , Task.perform SetTime Date.now
        ]
    )



-- UPDATE


type Msg
    = SetTime Date.Date
    | Upload
    | SaveLog
    | DoLoadLog
    | DoLoad String
    | FilesSelect (List FR.NativeFile)
    | FileData (Result FR.Error String)
    | NewEntry
    | SaveEntry
    | SetDatePicker DatePicker.Msg
    | ToggleExercise String
    | AddSet String
    | RemoveSet String Int
    | SetReps String Int Int
    | ToggleWarmup String Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetTime date ->
            { model | date = Just date } ! []

        Upload ->
            case model.selectedFile of
                Just selected ->
                    { model | errors = [] } ! [ readTextFile selected ]

                Nothing ->
                    { model | errors = [] } ! []

        SaveLog ->
            model ! [ save model ]

        DoLoadLog ->
            model ! [ doLoadLog () ]

        DoLoad logStr ->
            let
                data =
                    JD.decodeString (JD.list Entry.decoder) logStr
            in
            case data of
                Ok entries ->
                    { model | entries = entries } ! []

                Err err ->
                    { model | errors = (err ++ " :: " ++ logStr) :: model.errors } ! []

        FilesSelect fileInstances ->
            { model
                | selectedFile = List.head fileInstances
            }
                ! []

        FileData (Ok str) ->
            let
                data =
                    JD.decodeString (JD.list Entry.decoder) str

                newModel =
                    case data of
                        Ok d ->
                            { model | uploadedFileContents = str, entries = d }

                        Err err ->
                            { model | errors = (err ++ " :: " ++ str) :: model.errors }
            in
            newModel ! [ save newModel ]

        FileData (Err err) ->
            { model | errors = FR.prettyPrint err :: model.errors } ! []

        NewEntry ->
            { model | editEntry = Just (Entry.Entry (dateToString model.date) "" []) } ! []

        SaveEntry ->
            let
                newModel =
                    case model.editEntry of
                        Just entry ->
                            { model | entries = entry :: model.entries, editEntry = Nothing }

                        Nothing ->
                            model
            in
            newModel ! [ save newModel ]

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

                strDate =
                    dateToString date

                existingEntry =
                    List.head <| List.filter (\e -> e.date == strDate) model.entries

                newEntry =
                    case existingEntry of
                        Nothing ->
                            Debug.log (toString <| model.entries) <| Maybe.map (\e -> { e | date = strDate }) model.editEntry

                        Just entry ->
                            Debug.log entry.notes existingEntry
            in
            { model
                | date = date
                , datePicker = newDatePicker
                , editEntry = newEntry
            }
                ! [ Cmd.map SetDatePicker datePickerCmd ]

        ToggleExercise exerciseName ->
            case model.editEntry of
                Nothing ->
                    model ! []

                Just entry ->
                    let
                        isPresent =
                            List.member exerciseName (List.map (\s -> s.name) entry.exercises)
                    in
                    if isPresent then
                        let
                            newEntry =
                                Maybe.map (\e -> { e | exercises = List.filter (\e -> e.name /= exerciseName) e.exercises }) model.editEntry
                        in
                        { model | editEntry = newEntry } ! []
                    else
                        let
                            newEntry =
                                Maybe.map (\e -> { e | exercises = e.exercises ++ [ Entry.Exercise exerciseName [] ] }) model.editEntry
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


save : Model -> Cmd msg
save model =
    saveLog <| JE.encode 0 <| JE.list <| List.map Entry.encode model.entries



-- SUBSCRIPTIONS


port saveLog : String -> Cmd msg


port loadLog : (String -> msg) -> Sub msg


port doLoadLog : () -> Cmd msg


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
                , Html.fieldset [] (List.map exerciseGroupSelect (Dict.keys Exercise.groups))
                , Html.div [] (List.map viewEditEntryExercise entry.exercises)
                , Html.button [ Events.onClick SaveEntry ] [ Html.text "Save" ]
                ]


viewEditEntryExercise : Entry.Exercise -> Html.Html Msg
viewEditEntryExercise exercise =
    Html.div []
        [ Html.h3 [] [ Html.text exercise.name ]
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
                , Attrs.checked set.warmup
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


exerciseGroupSelect : String -> Html.Html Msg
exerciseGroupSelect groupName =
    Html.div []
        [ Html.h3 [] [ Html.text groupName ]
        , Html.div [] (List.map exerciseSelect <| Maybe.withDefault [] <| Dict.get groupName Exercise.groups)
        ]


exerciseSelect : String -> Html.Html Msg
exerciseSelect exercise =
    Html.label []
        [ Html.input [ Attrs.type_ "checkbox", Events.onClick <| ToggleExercise exercise ] []
        , Html.text exercise
        ]


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
            String.join "-"
                [ toString (Date.year date)
                , String.padLeft 2 '0' <| monthToInt (Date.month date)
                , String.padLeft 2 '0' <| toString (Date.day date)
                ]

        Nothing ->
            "no date"

module Data.Entry
    exposing
        ( Entry
        , decoder
        , encode
        , entryToHtml
        )

import Html
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (decode, required)
import Json.Encode as Encode exposing (Value)
import Util exposing ((=>))


type alias Entry =
    { date : String
    , notes : String
    , exercises : List Exercise
    }


type alias Exercise =
    { name : String
    , sets : List Set
    }


type alias Set =
    { reps : Int
    , warmup : Bool
    }


decoder : Decoder Entry
decoder =
    decode Entry
        |> required "date" Decode.string
        |> required "notes" Decode.string
        |> required "exercises" (Decode.list exerciseDcoder)


exerciseDcoder : Decoder Exercise
exerciseDcoder =
    decode Exercise
        |> required "name" Decode.string
        |> required "sets" (Decode.list setDcoder)


setDcoder : Decoder Set
setDcoder =
    decode Set
        |> required "reps" Decode.int
        |> required "warmup" Decode.bool


encode : Entry -> Value
encode entry =
    Encode.object
        [ "date" => Encode.string entry.date
        , "notes" => Encode.string entry.notes
        , "exercises" => Encode.list (List.map encodeExercise entry.exercises)
        ]


encodeExercise : Exercise -> Value
encodeExercise exercise =
    Encode.object
        [ "name" => Encode.string exercise.name
        , "sets" => Encode.list (List.map encodeSet exercise.sets)
        ]


encodeSet : Set -> Value
encodeSet set =
    Encode.object
        [ "reps" => Encode.int set.reps
        , "warmup" => Encode.bool set.warmup
        ]


entryToHtml : Entry -> Html.Html msg
entryToHtml entry =
    Html.div []
        [ Html.h1 [] [ Html.text entry.date ]
        , Html.p [] [ Html.text entry.notes ]
        ]

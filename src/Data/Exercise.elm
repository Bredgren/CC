module Data.Exercise exposing (..)

import Dict


type Standard
    = Beginner
    | Intermediate
    | Progression


type alias ProgressionStandard =
    { standard : Standard
    , sets : Int
    , reps : Int
    }


all : Dict.Dict String (List ProgressionStandard)
all =
    Dict.fromList
        [ ( "Wall Pushups"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 25
            , ProgressionStandard Progression 3 50
            ]
          )
        , ( "Incline Pushups"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 20
            , ProgressionStandard Progression 3 40
            ]
          )
        , ( "Kneeling Pushups"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 15
            , ProgressionStandard Progression 3 30
            ]
          )
        , ( "Half Pushups"
          , [ ProgressionStandard Beginner 1 8
            , ProgressionStandard Intermediate 2 12
            , ProgressionStandard Progression 2 25
            ]
          )
        , ( "Full Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "Close Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "Uneven Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "Half One-Arm Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "Lever Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "One-Arm Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 1 100
            ]
          )
        , ( "Shoulderstand Squats"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 25
            , ProgressionStandard Progression 3 50
            ]
          )
        , ( "Jackknife Squats"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 20
            , ProgressionStandard Progression 3 40
            ]
          )
        , ( "Supported Squats"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 15
            , ProgressionStandard Progression 3 30
            ]
          )
        , ( "Half Squats"
          , [ ProgressionStandard Beginner 1 8
            , ProgressionStandard Intermediate 2 35
            , ProgressionStandard Progression 2 50
            ]
          )
        , ( "Full Squats"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 30
            ]
          )
        , ( "Close Squats"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "Uneven Squats"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "Half One-Leg Squats"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "Assisted One-Leg Squats"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "One-Leg Squats"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 50
            ]
          )
        , ( "Vertical Pulls"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 20
            , ProgressionStandard Progression 3 40
            ]
          )
        , ( "Horizontal Pulls"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 20
            , ProgressionStandard Progression 3 30
            ]
          )
        , ( "Jackknife Pulls"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 15
            , ProgressionStandard Progression 3 20
            ]
          )
        , ( "Half Pullups"
          , [ ProgressionStandard Beginner 1 8
            , ProgressionStandard Intermediate 2 11
            , ProgressionStandard Progression 2 15
            ]
          )
        , ( "Full Pullups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 8
            , ProgressionStandard Progression 2 10
            ]
          )
        , ( "Close Pullups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 8
            , ProgressionStandard Progression 2 10
            ]
          )
        , ( "Uneven Pullups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 7
            , ProgressionStandard Progression 2 9
            ]
          )
        , ( "Half One-Arm Pullups"
          , [ ProgressionStandard Beginner 1 4
            , ProgressionStandard Intermediate 2 6
            , ProgressionStandard Progression 2 8
            ]
          )
        , ( "Assisted One-Arm Pullups"
          , [ ProgressionStandard Beginner 1 3
            , ProgressionStandard Intermediate 2 5
            , ProgressionStandard Progression 2 7
            ]
          )
        , ( "One-Arm Pullups"
          , [ ProgressionStandard Beginner 1 1
            , ProgressionStandard Intermediate 2 3
            , ProgressionStandard Progression 2 6
            ]
          )
        , ( "Knee Tucks"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 25
            , ProgressionStandard Progression 3 40
            ]
          )
        , ( "Flat Knee Raises"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 20
            , ProgressionStandard Progression 3 35
            ]
          )
        , ( "Flat Frog Raises"
          , [ ProgressionStandard Beginner 1 8
            , ProgressionStandard Intermediate 2 15
            , ProgressionStandard Progression 3 25
            ]
          )
        , ( "Flat Straight Leg Raises"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "Hanging Knee Raises"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 15
            ]
          )
        , ( "Hanging Bent Leg Raises"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 15
            ]
          )
        , ( "Partial Straight Leg Raises"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 15
            ]
          )
        , ( "Hanging Straight Leg Raises"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 30
            ]
          )
        , ( "Short Bridges"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 25
            , ProgressionStandard Progression 3 50
            ]
          )
        , ( "Straight Bridges"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 2 20
            , ProgressionStandard Progression 3 40
            ]
          )
        , ( "Head Bridges"
          , [ ProgressionStandard Beginner 1 8
            , ProgressionStandard Intermediate 2 15
            , ProgressionStandard Progression 2 25
            ]
          )
        , ( "Full Bridges"
          , [ ProgressionStandard Beginner 1 6
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 15
            ]
          )
        , ( "Wall Walking Bridges (Down)"
          , [ ProgressionStandard Beginner 1 3
            , ProgressionStandard Intermediate 2 6
            , ProgressionStandard Progression 2 10
            ]
          )
        , ( "Wall Walking Bridges (Up)"
          , [ ProgressionStandard Beginner 1 2
            , ProgressionStandard Intermediate 2 4
            , ProgressionStandard Progression 2 8
            ]
          )
        , ( "Closing Bridges"
          , [ ProgressionStandard Beginner 1 1
            , ProgressionStandard Intermediate 2 3
            , ProgressionStandard Progression 2 6
            ]
          )
        , ( "Stand-To-Stand Bridges"
          , [ ProgressionStandard Beginner 1 1
            , ProgressionStandard Intermediate 2 3
            , ProgressionStandard Progression 2 30
            ]
          )
        , ( "Wall Headstands"
          , [ ProgressionStandard Beginner 1 30
            , ProgressionStandard Intermediate 1 60
            , ProgressionStandard Progression 1 120
            ]
          )
        , ( "Crow Stands"
          , [ ProgressionStandard Beginner 1 10
            , ProgressionStandard Intermediate 1 30
            , ProgressionStandard Progression 1 60
            ]
          )
        , ( "Wall Handstands"
          , [ ProgressionStandard Beginner 1 30
            , ProgressionStandard Intermediate 1 60
            , ProgressionStandard Progression 1 120
            ]
          )
        , ( "Half Handstand Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 20
            ]
          )
        , ( "Handstand Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 10
            , ProgressionStandard Progression 2 15
            ]
          )
        , ( "Close Handstand Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 9
            , ProgressionStandard Progression 2 12
            ]
          )
        , ( "Uneven Handstand Pushups"
          , [ ProgressionStandard Beginner 1 5
            , ProgressionStandard Intermediate 2 8
            , ProgressionStandard Progression 2 10
            ]
          )
        , ( "Half One-Arm Handstand Pushups"
          , [ ProgressionStandard Beginner 1 4
            , ProgressionStandard Intermediate 2 6
            , ProgressionStandard Progression 2 8
            ]
          )
        , ( "Lever Handstand Pushups"
          , [ ProgressionStandard Beginner 1 3
            , ProgressionStandard Intermediate 2 4
            , ProgressionStandard Progression 2 6
            ]
          )
        , ( "One-Arm Handstand Pushups"
          , [ ProgressionStandard Beginner 1 1
            , ProgressionStandard Intermediate 2 2
            , ProgressionStandard Progression 1 5
            ]
          )
        ]


groups : Dict.Dict String (List String)
groups =
    Dict.fromList
        [ ( "Pushups"
          , [ "Wall Pushups"
            , "Incline Pushups"
            , "Kneeling Pushups"
            , "Half Pushups"
            , "Full Pushups"
            , "Close Pushups"
            , "Uneven Pushups"
            , "Half One-Arm Pushups"
            , "Lever Pushups"
            , "One-Arm Pushups"
            ]
          )
        , ( "Squats"
          , [ "Shoulderstand Squats"
            , "Jackknife Squats"
            , "Supported Squats"
            , "Half Squats"
            , "Full Squats"
            , "Close Squats"
            , "Uneven Squats"
            , "Half One-Leg Squats"
            , "Assisted One-Leg Squats"
            , "One-Leg Squats"
            ]
          )
        , ( "Pullups"
          , [ "Vertical Pulls"
            , "Horizontal Pulls"
            , "Jackknife Pulls"
            , "Half Pullups"
            , "Full Pullups"
            , "Close Pullups"
            , "Uneven Pullups"
            , "Half One-Arm Pullups"
            , "Assisted One-Arm Pullups"
            , "One-Arm Pullups"
            ]
          )
        , ( "Leg Raises"
          , [ "Knee Tucks"
            , "Flat Knee Raises"
            , "Flat Bent Leg Raises"
            , "Flat Frog Raises"
            , "Flat Straight Leg Raises"
            , "Hanging Knee Raises"
            , "Hanging Bent Leg Raises"
            , "Hanging Frog Raises"
            , "Partial Straight Leg Raises"
            , "Hanging Straight Leg Raises"
            ]
          )
        , ( "Bridges"
          , [ "Short Bridges"
            , "Straight Bridges"
            , "Angled Bridges"
            , "Head Bridges"
            , "Half Bridges"
            , "Full Bridges"
            , "Wall Walking Bridges (Down)"
            , "Wall Walking Bridges (Up)"
            , "Closing Bridges"
            , "Stand-To-Stand Bridges"
            ]
          )
        , ( "Headstand Pushups"
          , [ "Wall Headstands"
            , "Crow Stands"
            , "Wall Handstands"
            , "Half Handstand Pushups"
            , "Handstand Pushups"
            , "Close Handstand Pushups"
            , "Uneven Handstand Pushups"
            , "Half One-Arm Handstand Pushups"
            , "Lever Handstand Pushups"
            , "One-Arm Handstand Pushups"
            ]
          )
        ]


progressionByGroup : Dict.Dict String (List ( String, ProgressionStandard ))
progressionByGroup =
    let
        exerciseToProgressions exerciseName =
            Dict.get exerciseName all
                |> Maybe.withDefault []
                |> List.map (\p -> ( exerciseName, p ))
    in
    Dict.toList groups
        |> List.map (\g -> ( Tuple.first g, List.concatMap exerciseToProgressions (Tuple.second g) ))
        |> Dict.fromList

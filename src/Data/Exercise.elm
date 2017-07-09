module Data.Exercise exposing (..)

import Dict


type alias Standard =
    { sets : Int
    , reps : Int
    }


type alias Desc =
    { beginnerStandard : Standard
    , intermediateStandard : Standard
    , progressionStandard : Standard
    }


all : Dict.Dict String Desc
all =
    Dict.fromList
        [ ( "Wall Pushups"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 25 }
            , progressionStandard = { sets = 3, reps = 50 }
            }
          )
        , ( "Incline Pushups"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 20 }
            , progressionStandard = { sets = 3, reps = 40 }
            }
          )
        , ( "Kneeling Pushups"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 15 }
            , progressionStandard = { sets = 3, reps = 30 }
            }
          )
        , ( "Half Pushups"
          , { beginnerStandard = { sets = 1, reps = 8 }
            , intermediateStandard = { sets = 2, reps = 12 }
            , progressionStandard = { sets = 2, reps = 25 }
            }
          )
        , ( "Full Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "Close Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "Uneven Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "Half One-Arm Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "Lever Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "One-Arm Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 1, reps = 100 }
            }
          )
        , ( "Shoulderstand Squats"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 25 }
            , progressionStandard = { sets = 3, reps = 50 }
            }
          )
        , ( "Jackknife Squats"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 20 }
            , progressionStandard = { sets = 3, reps = 40 }
            }
          )
        , ( "Supported Squats"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 15 }
            , progressionStandard = { sets = 3, reps = 30 }
            }
          )
        , ( "Half Squats"
          , { beginnerStandard = { sets = 1, reps = 8 }
            , intermediateStandard = { sets = 2, reps = 35 }
            , progressionStandard = { sets = 2, reps = 50 }
            }
          )
        , ( "Full Squats"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 30 }
            }
          )
        , ( "Close Squats"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "Uneven Squats"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "Half One-Leg Squats"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "Assisted One-Leg Squats"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "One-Leg Squats"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 50 }
            }
          )
        , ( "Vertical Pulls"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 20 }
            , progressionStandard = { sets = 3, reps = 40 }
            }
          )
        , ( "Horizontal Pulls"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 20 }
            , progressionStandard = { sets = 3, reps = 30 }
            }
          )
        , ( "Jackknife Pulls"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 15 }
            , progressionStandard = { sets = 3, reps = 20 }
            }
          )
        , ( "Half Pullups"
          , { beginnerStandard = { sets = 1, reps = 8 }
            , intermediateStandard = { sets = 2, reps = 11 }
            , progressionStandard = { sets = 2, reps = 15 }
            }
          )
        , ( "Full Pullups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 8 }
            , progressionStandard = { sets = 2, reps = 10 }
            }
          )
        , ( "Close Pullups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 8 }
            , progressionStandard = { sets = 2, reps = 10 }
            }
          )
        , ( "Uneven Pullups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 7 }
            , progressionStandard = { sets = 2, reps = 9 }
            }
          )
        , ( "Half One-Arm Pullups"
          , { beginnerStandard = { sets = 1, reps = 4 }
            , intermediateStandard = { sets = 2, reps = 6 }
            , progressionStandard = { sets = 2, reps = 8 }
            }
          )
        , ( "Assisted One-Arm Pullups"
          , { beginnerStandard = { sets = 1, reps = 3 }
            , intermediateStandard = { sets = 2, reps = 5 }
            , progressionStandard = { sets = 2, reps = 7 }
            }
          )
        , ( "One-Arm Pullups"
          , { beginnerStandard = { sets = 1, reps = 1 }
            , intermediateStandard = { sets = 2, reps = 3 }
            , progressionStandard = { sets = 2, reps = 6 }
            }
          )
        , ( "Knee Tucks"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 25 }
            , progressionStandard = { sets = 3, reps = 40 }
            }
          )
        , ( "Flat Knee Raises"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 20 }
            , progressionStandard = { sets = 3, reps = 35 }
            }
          )
        , ( "Flat Frog Raises"
          , { beginnerStandard = { sets = 1, reps = 8 }
            , intermediateStandard = { sets = 2, reps = 15 }
            , progressionStandard = { sets = 3, reps = 25 }
            }
          )
        , ( "Flat Straight Leg Raises"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "Hanging Knee Raises"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 15 }
            }
          )
        , ( "Hanging Bent Leg Raises"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 15 }
            }
          )
        , ( "Partial Straight Leg Raises"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 15 }
            }
          )
        , ( "Hanging Straight Leg Raises"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 30 }
            }
          )
        , ( "Short Bridges"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 25 }
            , progressionStandard = { sets = 3, reps = 50 }
            }
          )
        , ( "Straight Bridges"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 2, reps = 20 }
            , progressionStandard = { sets = 3, reps = 40 }
            }
          )
        , ( "Head Bridges"
          , { beginnerStandard = { sets = 1, reps = 8 }
            , intermediateStandard = { sets = 2, reps = 15 }
            , progressionStandard = { sets = 2, reps = 25 }
            }
          )
        , ( "Full Bridges"
          , { beginnerStandard = { sets = 1, reps = 6 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 15 }
            }
          )
        , ( "Wall Walking Bridges (Down)"
          , { beginnerStandard = { sets = 1, reps = 3 }
            , intermediateStandard = { sets = 2, reps = 6 }
            , progressionStandard = { sets = 2, reps = 10 }
            }
          )
        , ( "Wall Walking Bridges (Up)"
          , { beginnerStandard = { sets = 1, reps = 2 }
            , intermediateStandard = { sets = 2, reps = 4 }
            , progressionStandard = { sets = 2, reps = 8 }
            }
          )
        , ( "Closing Bridges"
          , { beginnerStandard = { sets = 1, reps = 1 }
            , intermediateStandard = { sets = 2, reps = 3 }
            , progressionStandard = { sets = 2, reps = 6 }
            }
          )
        , ( "Stand-To-Stand Bridges"
          , { beginnerStandard = { sets = 1, reps = 1 }
            , intermediateStandard = { sets = 2, reps = 3 }
            , progressionStandard = { sets = 2, reps = 30 }
            }
          )
        , ( "Wall Headstands"
          , { beginnerStandard = { sets = 1, reps = 30 }
            , intermediateStandard = { sets = 1, reps = 60 }
            , progressionStandard = { sets = 1, reps = 120 }
            }
          )
        , ( "Crow Stands"
          , { beginnerStandard = { sets = 1, reps = 10 }
            , intermediateStandard = { sets = 1, reps = 30 }
            , progressionStandard = { sets = 1, reps = 60 }
            }
          )
        , ( "Wall Handstands"
          , { beginnerStandard = { sets = 1, reps = 30 }
            , intermediateStandard = { sets = 1, reps = 60 }
            , progressionStandard = { sets = 1, reps = 120 }
            }
          )
        , ( "Half Handstand Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 20 }
            }
          )
        , ( "Handstand Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 10 }
            , progressionStandard = { sets = 2, reps = 15 }
            }
          )
        , ( "Close Handstand Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 9 }
            , progressionStandard = { sets = 2, reps = 12 }
            }
          )
        , ( "Uneven Handstand Pushups"
          , { beginnerStandard = { sets = 1, reps = 5 }
            , intermediateStandard = { sets = 2, reps = 8 }
            , progressionStandard = { sets = 2, reps = 10 }
            }
          )
        , ( "Half One-Arm Handstand Pushups"
          , { beginnerStandard = { sets = 1, reps = 4 }
            , intermediateStandard = { sets = 2, reps = 6 }
            , progressionStandard = { sets = 2, reps = 8 }
            }
          )
        , ( "Lever Handstand Pushups"
          , { beginnerStandard = { sets = 1, reps = 3 }
            , intermediateStandard = { sets = 2, reps = 4 }
            , progressionStandard = { sets = 2, reps = 6 }
            }
          )
        , ( "One-Arm Handstand Pushups"
          , { beginnerStandard = { sets = 1, reps = 1 }
            , intermediateStandard = { sets = 2, reps = 2 }
            , progressionStandard = { sets = 1, reps = 5 }
            }
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

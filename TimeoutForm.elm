module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (style, value, disabled)
import Html.Events exposing (onInput)
import Time exposing (..)


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { name : String, timeLeft : Int }


initialModel : Model
initialModel =
    { name = "Leia", timeLeft = 10 }


init : ( Model, Cmd Msg )
init =
    initialModel ! []



-- UPDATE


type Msg
    = SetName String
    | Tick Float


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetName name ->
            { model | name = name, timeLeft = initialModel.timeLeft } ! []

        Tick _ ->
            { model
                | timeLeft =
                    if (model.timeLeft > 0) then
                        model.timeLeft - 1
                    else
                        0
            }
                ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        timeLeftColor timeLeft =
            if timeLeft > 5 then
                "green"
            else if timeLeft > 0 then
                "orange"
            else
                "red"
    in
        div []
            [ h1 [] [ text "Timeout form" ]
            , label [] [ text "Enter your Name:" ]
            , input
                [ value model.name
                , onInput SetName
                , disabled (model.timeLeft == 0)
                ]
                []
            , p [] [ text ("Your entered Name is " ++ model.name) ]
            , p
                [ style
                    [ ( "color", timeLeftColor model.timeLeft )
                    , ( "font-weight", "bold" )
                    ]
                ]
                [ text ("Time left " ++ toString model.timeLeft) ]
            ]
